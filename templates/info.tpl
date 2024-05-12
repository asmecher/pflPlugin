{**
 * templates/info.tpl
 *
 * Copyright (c) 2024 Simon Fraser University
 * Copyright (c) 2024 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Display information about the Publication Facts Label
 *}

{include file="frontend/components/header.tpl" pageTitle="plugins.generic.pflPlugin.about"}

<link rel="stylesheet" href="{$baseUrl}/plugins/generic/pflPlugin/css/pfl.css" type="text/css">

<div id="pfl-info-page">

    <div id="pfl-info-page-header" tabindex="0">
        <h1 id="pfl-info-header_01">{translate key="plugins.generic.pflPlugin.aboutHeader_01"}</h1>
        <h2 id="pfl-info-header_02">{translate key="plugins.generic.pflPlugin.aboutHeader_02"}</h2>
    </div>
        
    <section tabindex="0">
        <p id="pfl-info-page-intro"> {translate key="plugins.generic.pflPlugin.aboutDescription"}</p>
    </section>

    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutOtherArticles"}
    </section>

    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutOtherJournals"}
    </section>
        
    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutPeerReviewers"}
    </section>

    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutReviewerProfiles" orcidIconUrl=$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}
    </section>

    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutAuthorStatements"}
    </section>
        
    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutCompetingInterests"}
    </section>

    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutDataAvailability"}
    </section>

    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutExternalFunding"}
    </section>

    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutArticlesAccepted"}
    </section>
        
    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutDaysToPublication"}
    </section>

    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutIndexing"}
    </section>

    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutEditorAndBoardMemberProfiles" orcidIconUrl=$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}
    </section>

    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutAcademicSociety"}
    </section>

    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutPublisher"}
    </section>
        
    <section tabindex="0">
        {translate key="plugins.generic.pflPlugin.aboutListOfJournals"}	
    </section>

</div>

{include file="frontend/components/footer.tpl"}

