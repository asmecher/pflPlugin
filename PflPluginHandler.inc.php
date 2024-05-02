<?php

/**
 * @file PflPluginHandler.inc.php
 *
 * Copyright (c) 2024 Simon Fraser University
 * Copyright (c) 2024 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @package plugins.generic.pflPlugin
 * @class PflPluginHandler
 */

import('classes.handler.Handler');

class PflPluginHandler extends Handler {
    static $plugin;
    static $staticPage;

    /**
     * Provide the plugin to the handler.
     * @param $plugin PflPlugin
     */
    static function setPlugin($plugin) {
        self::$plugin = $plugin;
    }

    /**
     * Handle index request (redirect to "view")
     * @param $args array Arguments array.
     * @param $request PKPRequest Request object.
     */
    function index($args, $request) {
        $this->setupTemplate($request);
        $templateMgr = TemplateManager::getManager($request);

        $templateMgr->display(self::$plugin->getTemplateResource('info.tpl'));
    }
}

