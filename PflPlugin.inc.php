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

        $request = Application::get()->getRequest();
        $journal = $request->getContext();
        if (!$journal) return false;

        $templateMgr = TemplateManager::getManager();
        if ($templateMgr->getTemplateVars('pflDisplayed')) return false; // Only display the PFL once per request

        // Journal-specific PFL data
        $templateMgr->assign([
            'pflDisplayed' => true, // Set a flag so the PFL is not displayed multiple times
            'pflAcceptedPercent' => $this->getAcceptedPercent($journal->getId()),
            'pflPublisherName' => $journal->getData('publisherInstitution'),
            'pflPublisherUrl' => null, // FIXME: https://github.com/asmecher/pflPlugin/issues/2
            'pflNumOfferProfiles' => null, // FIXME: Data not yet available
            'pflIndexList' => [], // FIXME: Data not yet available
            'pflEditorialTeamUrl' => '', // FIXME: URL not yet available
        ]);
        // Journal class data
        $templateMgr->assign([
            'pflNumOfferProfilesClass' => 65,
            'pflNumAcceptedClass' => 13,
            'pflNumIndexesClass' => '15.6',
        ]);

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
            // Article class data
            $templateMgr->assign([
                'pflReviewerCountClass' => '2.4',
                'pflCompetingInterestsPercentClass' => 11,
                'pflDataAvailabilityPercentClass' => 16,
                'pflNumHaveFundersClass' => 32,
            ]);
        }

        // FIXME: Add fake data overrides for testing purposes.
        $templateMgr->assign([
            // Journal-wide
            'pflPublisherName' => 'Ubiquity Press',
            'pflPublisherUrl' => 'https://www.ubiquitypress.com/',
            'pflAcceptedPercent' => 8,
            'pflIndexList' => ["https://scholar.google.com/" => 'GS', "https://www.nlm.nih.gov/medline/medline_overview.html" => 'M', "https://clarivate.com/products/scientific-and-academic-research/research-discovery-and-workflow-solutions/webofscience-platform/" => 'WS', "https://www.elsevier.com/solutions/scopus" => 'S'],
            'pflEditorialTeamUrl' => $request->url(null, 'about', 'editorialTeam'),
            // Article-specific
            'pflReviewerCount' => 2,
            'pflPeerReviewersUrl' => $request->url(null, 'about', 'editorialTeam'),
            'pflCompetingInterestsUrl' => 'https://ojs.stanford.edu/ojs/index.php/jii/ci',
            'pflDataAvailabilityUrl' => 'https://ojs.stanford.edu/ojs/index.php/jii/data',
            'pflFunderList' => ['https://www.aamc.org/' => 'AAMC'],
        ]);

        $templateMgr->display($this->getTemplateResource('pfl.tpl'));
        return false;
    }
}
