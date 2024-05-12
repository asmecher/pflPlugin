{**
* templates/pfl.tpl
*
* Copyright (c) 2023 Simon Fraser University
* Copyright (c) 2023 John Willinsky
* Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
*
* Journal Integrity Initiative Publication Facts Label template
*}


<link rel="stylesheet" href="{$baseUrl}/plugins/generic/pflPlugin/css/pfl.css" type="text/css">
 

<script>
    document.addEventListener('DOMContentLoaded', function() {
        function pflShowHideFactsLabel() {
            const toggleButton = document.getElementById("pfl-button-open-facts");
            const pflFactTable = document.getElementById("pfl-fact-table");
            const pflContainer = document.getElementById("pfl-container");
            const highlightDropdown = document.querySelector(".dropdown");
            const placeHolderText = document.getElementById("buttonText");
            
            if (!toggleButton || !pflFactTable || !pflContainer || !highlightDropdown || !placeHolderText) {
                console.error("One or more required elements are missing.");

                return;
            }

            const ariaExpandedAttr = toggleButton.getAttribute("aria-expanded");

            if (ariaExpandedAttr === "false") {
                toggleButton.setAttribute("aria-expanded", "true")

                pflContainer.classList.add("expanded");
                highlightDropdown.classList.add("expanded");
                placeHolderText.style.visibility = "hidden";
                
                pflFactTable.style.display = "block";
                pflFactTable.focus();
            } else {
                toggleButton.setAttribute("aria-expanded","false");

                pflContainer.classList.remove("expanded");
                highlightDropdown.classList.remove("expanded");
                placeHolderText.style.visibility = "visible";

                pflFactTable.style.display = "none";
            }
        }
            const toggleButton = document.getElementById('pfl-button-open-facts');
            
            if (toggleButton) {
                toggleButton.addEventListener('click', pflShowHideFactsLabel);
            }
    });
</script>
 

<div class="publication-facts-label">
 
    <div class="dropdown">
        <button id="pfl-button-open-facts" aria-label="{translate key="plugins.generic.pfl.publicationFactsButton"}" aria-controls="pfl-fact-table" aria-expanded="false">
            <span id="buttonText">{translate key="plugins.generic.pfl.publicationFacts"}</span>
        </button>
    </div>
 
    <div id="pfl-container" class="pfl-container">

        <div id="pfl-fact-table" class="pfl-tables" role="region">
 
            <h2 id="pfl-title" aria-label="{translate key="plugins.generic.pfl.publicationFactsLabelTitle"}" role="title" data-name="pfl-title" tabindex="0">{translate key="plugins.generic.pfl.publicationFactsTitle"}</h2>
 
            {if $article}
                
            <table tabindex="0">

                <thead class="pfl-table-header">
                    <tr>
                        <th class="pfl-table-header-left">
                            {translate key="plugins.generic.pfl.thisArticle"}
                        </th>
                        <th  class="pfl-table-header-right">
                            {translate key="plugins.generic.pfl.otherArticles"}
                        </th>
                    </tr>
                </thead>

                <tbody class="pfl-table-cells">
                
                    <tr>
                        <td class="pfl-table-cells-left" tabindex="0" aria-label="{translate key="plugins.generic.pfl.thisArticleHas"}">
                            {translate key="plugins.generic.pfl.numPeerReviewers" peerReviewersUrl=$pflPeerReviewersUrl num=$pflReviewerCount|escape}
                        </td>
                        <td class="pfl-table-cells-right" tabindex="0" aria-label="{translate key="plugins.generic.pfl.otherArticlesHave"}">
                            <span>
                                {translate key="plugins.generic.pfl.averagePeerReviewers" num=$pflReviewerCountClass}
                            </span>
                        </td>
                    </tr>
                </tbody>

            </table>

            {* $editorialTeamUrl doesn't seem to point to the correct place inside the template *}

            <div class="pfl-list-item" tabindex="0" aria-label="{translate key="plugins.generic.pfl.reviewerProfiles"}">
                <div class="pfl-indent">
                    <p class="pfl-orcid-icon">{translate key="plugins.generic.pfl.reviewerProfiles_01"}

                        <img src="{$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}" alt="ORCiD logo image">

                        <a href="{$editorialTeamUrl}" aria-label="{translate key="plugins.generic.pfl.linkToReviewerProfiles"}" target="_blank">{translate key="plugins.generic.pfl.profiles"} </a>

                    </p>
                </div>
            </div>

            <h3 class="pfl-list-item pfl-paragraph-item" tabindex="0">
                <div class="pfl-table-cells-left">{translate key="plugins.generic.pfl.authorStatements"}</div>
            </h3>

            <table tabindex="0">
                <tbody>
                    <tr>
                        <td class="pfl-list-item" tabindex="0" aria-label="{translate key="plugins.generic.pfl.thisArticleHas"}">
                            <div class="pfl-indent">
                                <span class="pfl-left-align" tabindex="1">
                                    {if $pflDataAvailabilityUrl}
                                        {translate key="plugins.generic.pfl.dataAvailability.yes" dataAvailabilityUrl=$pflDataAvailabilityUrl}
                                    {else}
                                        {translate key="plugins.generic.pfl.dataAvailability.no"}
                                    {/if}
                                </span>
                            </div>
                        </td>
                        <td class="pfl-right-align" tabindex="0" aria-label="{translate key="plugins.generic.pfl.otherArticlesHave"}">
                            {translate key="plugins.generic.pfl.percentYes" num=$pflDataAvailabilityPercentClass}
                        </td>
                    </tr>
                    <tr>
                        <td class="pfl-list-item" tabindex="0" aria-label="{translate key="plugins.generic.pfl.thisArticleHas"}">
                            <div class="pfl-indent">
                                <span class="pfl-left-align" tabindex="1">
                                    {if $pflFunderList}
                                        {translate key="plugins.generic.pfl.funders.yes" pflFunderList=$pflpflNumHaveFundersClass}
                                    {else}
                                        {translate key="plugins.generic.pfl.funders.no"}
                                    {/if}
                                </span>
                            </div>
                        </td>
                        <td class="pfl-right-align" tabindex="0" aria-label="{translate key="plugins.generic.pfl.otherArticlesHave"}">
                            {translate key="plugins.generic.pfl.numHaveFunders" num=$pflNumHaveFundersClass}
                        </td>
                    <tr class="pfl-last">
                        <td tabindex="0" aria-label="{translate key="plugins.generic.pfl.thisArticleHas"}">
                            <div class="pfl-indent">
                                <span class="pfl-left-align" tabindex="1"> 

                                    {* Missing link for the "Yes" option *}

                                    {if $pflCompetingInterests}
                                        {translate key="plugins.generic.pfl.competingInterests.yes"}
                                    {else}
                                        {translate key="plugins.generic.pfl.competingInterests.no"}
                                    {/if}
                                </span>
                            </div>
                        </td>
                        <td class="pfl-right-align" tabindex="0" aria-label="{translate key="plugins.generic.pfl.otherArticlesHave"}">
                            {translate key="plugins.generic.pfl.percentYes" num=$pflCompetingInterestsPercentClass|escape}
                        </td>
                    </tr>
                </tbody>
            </table>

            {/if} {* If this is an article-specific page *}

            <table tabindex="0">
                <thead>
                    <tr class="pfl-table-header">
                        <th class="pfl-table-header-left">
                            {translate key="plugins.generic.pfl.forThisJournal"}
                        </th>
                        <th class="pfl-table-header-right">
                            {translate key="plugins.generic.pfl.otherJournals"}
                        </th>
                    </tr>
                </thead>

                <tbody>
                    <tr class="pfl-table-cells">
                        <td class="pfl-table-cells-left" tabindex="0" aria-label="{translate key="plugins.generic.pfl.thisJournalHas"}">
                            {translate key="plugins.generic.pfl.numArticlesAccepted" num=$pflAcceptedPercent|escape}
                        </td>
                        <td class="pfl-table-cells-right" tabindex="0" aria-label="{translate key="plugins.generic.pfl.otherJournalsHave"}">
                            {translate key="plugins.generic.pfl.numArticlesAcceptedShort" num=$pflNumAcceptedClass}
                        </td>
                    </tr>

                    {* Dynamic count numbers missing here *}

                    <tr class="pfl-list-item">
                        <td class="pfl-indent" tabindex="0" aria-label="{translate key="plugins.generic.pfl.thisJournalHas"}">
                            {translate key="plugins.generic.pfl.daysToPublication"} {$pflDaysToPublication|escape}
                        </td>
                        <td class="pfl-right-align" tabindex="0" aria-label="{translate key="plugins.generic.pfl.otherJournalsHave"}">
                            {$pflDaysToPublicationClass|escape}
                        </td>
                    </tr>
                </tbody>
            </table>

            <ul class="pfl-list-item pfl-paragraph-item" tabindex="0" aria-label="{translate key="plugins.generic.pfl.journalIndexedIn"}">
                {capture assign="pflIndexListMarkup"}

                    {foreach from=$pflIndexList item=pflIndexListItemName key=pflIndexListItemUrl}
                        <li><a href="{$pflIndexListItemUrl|escape}" target="_blank">{$pflIndexListItemName|escape}</a></li>

                    {foreachelse}
                        &mdash;

                    {/foreach}
                    {/capture}
                    
                {translate key="plugins.generic.pfl.indexedIn" indexList=$pflIndexListMarkup}
            </ul>

            <dl role="presentation">
                <dt class="pfl-list-item pfl-paragraph-item">
                    <p class="pfl-orcid-icon" tabindex="0" aria-label="{translate key="plugins.generic.pfl.editorAndBoardMembers"}"> {translate key="plugins.generic.pfl.editorAndBoardMembers"}

                        <img src="{$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}" alt="ORCiD logo image">

                        <a href="{$editorialTeamUrl}" aria-label="{translate key="plugins.generic.pfl.linkToEditorAndBoardMembersProfiles"}" target="_blank">{translate key="plugins.generic.pfl.profiles"}</a>

                    </p>
                </dt>

                <dd class="pfl-list-item">
                    <div class="pfl-indent">
                        <p tabindex="0">
                            {translate key="plugins.generic.pfl.academicSociety"}
                            <a href="" target="_blank">N/A</a>
                        </p>
                    </div>
                </dd>

                {if $pflPublisherUrl or $pflPublisherName} 
                    <dd class="pfl-last">
                        <div class="pfl-indent">
                            <p tabindex="0">
                                {translate key="plugins.generic.pfl.publisher"}

                                {if $pflPublisherUrl}
                                    <a href="{$pflPublisherUrl|escape}" target="_blank">
                                        {$pflPublisherName|escape|default:"&mdash;"}
                                    </a>
                                {else}
                                    {$pflPublisherName|escape|default:"&mdash;"}
                                {/if}
                            </p>
                        </div>
                    </dd>
                {/if}

            </dl>

            <div id="pfl-table-footer">
                <a id="pfl-table-footer-info-link" tabindex="0" href="{url page="publicationFacts"}" target="_blank"> {translate key="plugins.generic.pfl.informationFooter"} <img class="pfl-info-icon" src="{$baseUrl|concat:'/plugins/generic/pflPlugin/img/info_icon.svg'}"></a>
                <p tabindex="0" aria-label="{translate key="plugins.generic.pfl.linkToPKPWebsite"}"> {translate key="plugins.generic.pfl.maintainedByPKP"}<a href="https://pkp.sfu.ca" target="_blank">Public Knowledge Project</a></p>
            </div>

        </div>

    </div>

</div>
 
