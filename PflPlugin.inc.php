<?php

/**
 * @file PflPlugin.inc.php
 *
 * Copyright (c) 2023 Simon Fraser University
 * Copyright (c) 2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Publication Facts Label plugin
 */

import('lib.pkp.classes.plugins.GenericPlugin');

class PflPlugin extends GenericPlugin {
    /**
     * @copydoc Plugin::register()
     */
    function register($category, $path, $mainContextId = null) {
        if (parent::register($category, $path, $mainContextId)) {
            if ($this->getEnabled($mainContextId)) {
                // HACK: We don't have a hook for the appropriate spot in the page presentation, so we watch for
                // the page footer template to be looked up. When that happens, we output the PFL markup directly.
                HookRegistry::register('TemplateResource::getFilename', [$this, 'getFilenameHook']);
            }
            return true;
        }
        return false;
    }

    /**
     * Get the display name of this plugin.
     * @return String
     */
    function getDisplayName() {
        return __('plugins.generic.pfl.displayName');
    }

    /**
     * Get a description of the plugin.
     */
    function getDescription() {
        return __('plugins.generic.pfl.description');
    }

    /**
     * Get the article acceptance percentage for a given journal.
     */
    function getAcceptedPercent($journalId) {
        $submissionDao = DAORegistry::getDAO('SubmissionDAO');
        import('lib.pkp.classes.workflow.PKPEditorDecisionActionsManager');
        $row = $submissionDao->retrieve(
            'SELECT COUNT(s.submission_id) AS submission_count, COUNT(eda.edit_decision_id) AS accepted_submission_count FROM submissions s
            LEFT JOIN edit_decisions eda ON (eda.submission_id = s.submission_id AND eda.decision = ?)
            LEFT JOIN edit_decisions edn ON (edn.submission_id = s.submission_id AND edn.decision = eda.decision AND edn.edit_decision_id > eda.edit_decision_id)
            WHERE s.context_id = ? AND s.submission_progress = 0 AND (edn.edit_decision_id IS NULL OR eda.edit_decision_id IS NOT NULL)',
            [SUBMISSION_EDITOR_RECOMMEND_ACCEPT, $journalId]
        )->current();
        $submissionCount = $row->submission_count;
        $acceptedSubmissionCount = $row->accepted_submission_count;
        if ($submissionCount == 0) return 0;
        return intval($acceptedSubmissionCount / $submissionCount * 100);
    }

    /**
     * Get the peer reviewer count for a given submission.
     */
    function getReviewerCount($submissionId) {
        $submissionDao = DAORegistry::getDAO('SubmissionDAO');
        $row = $submissionDao->retrieve(
            'SELECT COUNT(DISTINCT r.reviewer_id) AS reviewer_count FROM review_assignments r WHERE r.date_completed IS NOT NULL AND r.submission_id = ?',
            [$submissionId]
        )->current();
        return $row->reviewer_count;
    }

    /**
     * Hook callback for displaying the publication facts label.
     */
    function getFilenameHook($hookName, $args) {
        $filePath =& $args[0];
        $template =& $args[1];
        if ($template != 'frontend/components/footer.tpl') return false;

        // Only journal-specific pages get the PFL.
        $request = Application::get()->getRequest();
        $journal = $request->getContext();
        if (!$journal) return false;

        // Only page routers get the PFL.
        $router = $request->getRouter();
        if (!$router instanceof PageRouter) return false;

        // Only journal homepages and article landing pages get the PFL.
        if (!in_array($router->getRequestedPage($request) . '/' . $router->getRequestedOp($request), ['article/view', 'index/index'])) return false;

        $templateMgr = TemplateManager::getManager();
        if ($templateMgr->getTemplateVars('pflDisplayed')) return false; // Only display the PFL once per request

        $pflIndexList = [];
        $onlineIssn = urlencode($journal->getSetting('onlineIssn'));
        if ($this->getSetting($journal->getId(), 'includeDoaj')) $pflIndexList["https://doaj.org/toc/{$onlineIssn}"] = 'DOAJ';
        if ($this->getSetting($journal->getId(), 'includeScholar')) $pflIndexList["https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q={$onlineIssn}&btnG="] = 'GS';
        if ($this->getSetting($journal->getId(), 'includeMedline')) $pflIndexList["https://www.ncbi.nlm.nih.gov/nlmcatalog/?term=${onlineIssn}[ISSN]"] = 'M';
        if ($this->getSetting($journal->getId(), 'includeLatindex')) $pflIndexList["https://latindex.org/latindex/Solr/Busqueda?idModBus=0&buscar={$onlineIssn}&submit=Buscar"] = 'L';
        if ($scopusUrl = $this->getSetting($journal->getId(), 'scopusUrl')) $pflIndexList[$scopusUrl] = 'S';
        if ($wosUrl = $this->getSetting($journal->getId(), 'wosUrl')) $pflIndexList[$wosUrl] = 'WS';

        // Journal-specific PFL data
        $templateMgr->assign([
            'pflDisplayed' => true, // Set a flag so the PFL is not displayed multiple times
            'pflAcceptedPercent' => $this->getAcceptedPercent($journal->getId()),
            'pflPublisherName' => $journal->getData('publisherInstitution'),
            'pflPublisherUrl' => $journal->getData('publisherUrl'),
            'pflNumOfferProfiles' => null, // FIXME: Data not yet available
            'pflIndexList' => $pflIndexList,
            'pflEditorialTeamUrl' => '', // FIXME: URL not yet available
        ]);

        // Class data
        $templateMgr->assign(json_decode(file_get_contents(dirname(__FILE__) . '/classData.json'), JSON_OBJECT_AS_ARRAY));

        // If we're viewing an article-specific page...
        if ($article = $templateMgr->getTemplateVars('article')) {
            // Article-specific PFL data
            $templateMgr->assign([
                'pflReviewerCount' => $this->getReviewerCount($article->getId()),
                'pflCompetingInterestsUrl' => null, // FIXME: URL not yet available
                'pflPeerReviewersUrl' => '', // FIXME: URL not yet available
                'pflDataAvailabilityUrl' => '', // FIXME: URL not yet available
                'pflFunderList' => [], // FIXME: Data not yet available
            ]);
        }

        // FIXME: Add fake data overrides for testing purposes.
        $templateMgr->assign([
            // Journal-wide fake data
            'pflPublisherName' => 'Ubiquity Press',
            'pflPublisherUrl' => 'https://www.ubiquitypress.com/',
            'pflAcceptedPercent' => 8,
            'pflIndexList' => ['https://scholar.google.com/' => 'GS', 'https://www.nlm.nih.gov/medline/medline_overview.html' => 'M', 'https://clarivate.com/products/scientific-and-academic-research/research-discovery-and-workflow-solutions/webofscience-platform/' => 'WS', 'https://www.elsevier.com/solutions/scopus' => 'S'],
            'pflEditorialTeamUrl' => $request->url(null, 'about', 'editorialTeam'),
        ]);
        if ($article) {
            // Article-specific fake data
            $templateMgr->assign([
                'pflPeerReviewersUrl' => $request->url(null, 'about', 'editorialTeam'),
                'pflReviewerCount' => 2,
            ]);
            if ($article->getId() == 2268) $templateMgr->assign([ // Dog Genomics
                'pflCompetingInterestsUrl' => 'https://ojs.stanford.edu/ojs/index.php/jii/ci',
                'pflDataAvailabilityUrl' => 'https://ojs.stanford.edu/ojs/index.php/jii/data',
                'pflFunderList' => ['https://darwinsark.org/' => 'DAF', 'https://www.nih.gov/' => 'NIH', 'https://www.nsf.gov/' => 'NSF'],
            ]);
            else $templateMgr->assign([ // Academic Achievement
                'pflCompetingInterestsUrl' => null,
                'pflDataAvailabilityUrl' => null,
                'pflFunderList' => ['https://www.aamc.org/' => 'AAMC'],
            ]);
        }

        $templateMgr->display($this->getTemplateResource('pfl.tpl'));
        return false;
    }

	/**
	 * @see Plugin::getActions()
	 */
	public function getActions($request, $actionArgs) {

		$actions = parent::getActions($request, $actionArgs);

		if (!$this->getEnabled()) {
			return $actions;
		}

		$router = $request->getRouter();
		import('lib.pkp.classes.linkAction.request.AjaxModal');
		$linkAction = new LinkAction(
			'settings',
			new AjaxModal(
				$router->url(
					$request,
					null,
					null,
					'manage',
					null,
					array(
						'verb' => 'settings',
						'plugin' => $this->getName(),
						'category' => 'generic'
					)
				),
				$this->getDisplayName()
			),
			__('manager.plugins.settings'),
			null
		);

		array_unshift($actions, $linkAction);

		return $actions;
	}

	/**
	 * @see Plugin::manage()
	 */
	public function manage($args, $request) {
		switch ($request->getUserVar('verb')) {
			case 'settings':
				$this->import('PflSettingsForm');
				$form = new PflSettingsForm($this);

				if ($request->getUserVar('save')) {
					$form->readInputData();
					if ($form->validate()) {
						$form->execute();
						return new JSONMessage(true);
					}
				}

				$form->initData();
				return new JSONMessage(true, $form->fetch($request));
		}
		return parent::manage($args, $request);
	}

}
