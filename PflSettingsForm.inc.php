<?php
/**
 * @file PflSettingsForm.inc.php
 *
 * Copyright (c) 2023 Simon Fraser University
 * Copyright (c) 2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class PflSettingsForm
 * @ingroup plugins_generic_pflPlugin
 *
 * @brief Form for site admins to modify Publication Facts Label settings.
 */


import('lib.pkp.classes.form.Form');

class PflSettingsForm extends Form {

	/** @var $plugin object */
	public $plugin;

	/**
	 * Constructor
	 * @param $plugin object
	 */
	public function __construct($plugin) {
		parent::__construct($plugin->getTemplateResource('settings.tpl'));
		$this->plugin = $plugin;
		$this->addCheck(new FormValidatorPost($this));
		$this->addCheck(new FormValidatorCSRF($this));
		$this->addCheck(new FormValidatorUrl($this, 'scopusUrl', 'optional', 'plugins.generic.pflPlugin.settings.indexes.manual.scopus.urlInvalid'));
		$this->addCheck(new FormValidatorRegExp($this, 'scopusUrl', 'optional', 'plugins.generic.pflPlugin.settings.indexes.manual.scopus.urlInvalid', '/^https:\/\/www\.scopus\.com\/sourceid\/[0-9]+$/'));
	}

	/**
	* @copydoc Form::init
	*/
	public function initData() {
		$request = Application::get()->getRequest();
		$context = $request->getContext();
		$contextId = $context ? $context->getId() : 0;

		foreach (['includeMedline', 'includeDoaj', 'includeLatindex', 'includeScholar', 'scopusUrl'] as $settingName) {
			$this->setData($settingName, $this->plugin->getSetting($contextId, $settingName));
		}
	}

	/**
	 * Assign form data to user-submitted data.
	 */
	public function readInputData() {
		$this->readUserVars([
			'includeMedline', 'includeDoaj', 'includeLatindex', 'includeScholar', 'scopusUrl',
		]);
	}

	/**
	 * @copydoc Form::fetch()
	 */
	public function fetch($request, $template = null, $display = false) {
		$context = $request->getContext();

		$templateMgr = TemplateManager::getManager($request);
		$templateMgr->assign([
			'pluginName' => $this->plugin->getName(),
		]);

		return parent::fetch($request, $template, $display);
	}

	/**
	 * @copydoc Form::execute()
	 */
	public function execute(...$functionArgs) {
		$request = Application::get()->getRequest();
		$context = $request->getContext();

		foreach (['includeMedline', 'includeDoaj', 'includeLatindex', 'includeScholar'] as $booleanSettingName) {
			$this->plugin->updateSetting($context->getId(), $booleanSettingName, (bool) $this->getData($booleanSettingName));
		}

		foreach (['scopusUrl'] as $stringSettingName) {
			$this->plugin->updateSetting($context->getId(), $stringSettingName, (string) $this->getData($stringSettingName));
		}

		import('classes.notification.NotificationManager');
		$notificationMgr = new NotificationManager();
		$user = $request->getUser();
		$notificationMgr->createTrivialNotification($user->getId(), NOTIFICATION_TYPE_SUCCESS, array('contents' => __('common.changesSaved')));

		return parent::execute(...$functionArgs);
	}
}

