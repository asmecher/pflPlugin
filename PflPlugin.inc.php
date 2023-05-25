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
                HookRegistry::register('Templates::Article::Footer::PageFooter', [$this, 'display']);
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
    function display($hookName, $args) {
        $templateMgr =& $args[1];
        $output =& $args[2];
        $journal = Application::get()->getRequest()->getContext();
        $submission = $templateMgr->getTemplateVars('article');

        $templateMgr->assign([
            'pflAcceptedPercent' => $this->getAcceptedPercent($submission->getContextId()),
            'pflReviewerCount' => $this->getReviewerCount($submission->getId()),
        ]);
        $output .= $templateMgr->fetch($this->getTemplateResource('pfl.tpl'));
        return false;
    }
}
