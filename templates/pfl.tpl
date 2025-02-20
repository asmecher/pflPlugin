{**
* templates/pfl.tpl
*
* Copyright (c) 2023 Simon Fraser University
* Copyright (c) 2023 John Willinsky
* Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
*
* Journal Integrity Initiative Publication Facts Label template
*}

<section class="item pflPlugin">

<link rel="stylesheet" href="{$baseUrl}/plugins/generic/pflPlugin/css/pfl.css" type="text/css">

<style>
@font-face {
  font-family: 'Noto Sans';
  src: url({$baseUrl}/plugins/generic/pflPlugin/font/NotoSans-VariableFont_wdth,wght.woff2) format('woff2');
  font-weight: 100 900;
}
</style>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        function pflShowHideFactsLabel() {
            const toggleButton = document.getElementById("pfl-button-open-facts");
            const pflFactTable = document.getElementById("pfl-fact-table");
            const pflContainer = document.getElementById("pfl-container");
            const highlightDropdown = document.querySelector(".pfl-dropdown");
            const placeHolderText = document.getElementById("pfl-buttonText");
            const survey = document.getElementById("ff-compose");
            if (!toggleButton || !pflFactTable || !pflContainer || !highlightDropdown || !placeHolderText) {
                console.error("One or more required elements are missing.");
                return;
            }

            const ariaExpandedAttr = toggleButton.getAttribute("aria-expanded");

            if (ariaExpandedAttr === "false") {
                toggleButton.setAttribute("aria-expanded", "true")

                pflContainer.classList.add("expanded");
                highlightDropdown.classList.add("expanded");
                placeHolderText.classList.add("pfl-sr-only");
                
                pflFactTable.style.display = "block";
                if(survey) {
                    survey.style.display = "block";
                }
            } else {
                toggleButton.setAttribute("aria-expanded","false");

                pflContainer.classList.remove("expanded");
                highlightDropdown.classList.remove("expanded");
                placeHolderText.classList.remove("pfl-sr-only");

                pflFactTable.style.display = "none";
                
                if(survey) {
                    survey.style.display = "none";
                }
            }
        }

        const toggleButton = document.getElementById('pfl-button-open-facts');
        if (toggleButton) {
            toggleButton.addEventListener('click', pflShowHideFactsLabel);
        }

        function setPageDir() {
            const rtlLanguages = ['ar', 'he', 'fa', 'ur', 'syr', 'ps', 'ckb', 'prs', 'sd', 'ug', 'yi'];
            const userLang = (navigator.language || navigator.userLanguage || 'en').split("-")[0];

            const direction = rtlLanguages.some(lang => userLang.startsWith(lang)) ? 'rtl' : 'ltr';
            document.documentElement.setAttribute('dir', direction);
        }

        // Some supported themes do not set the "dir" attribute on the <body> tag, 
        // but many of our CSS rules depend on it. Thus, setting the "dir" attribute when it is missing
        if (!document.documentElement.hasAttribute('dir')) {
            setPageDir();
        }
    });
</script>
 

<div class="publication-facts-label">
 
    <div class="pfl-dropdown">
        <button id="pfl-button-open-facts" aria-controls="pfl-fact-table" aria-expanded="false">
            <span><span id="pfl-buttonText">{translate key="plugins.generic.pfl.publicationFacts"}</span></span><img src="{$baseUrl}/plugins/generic/pflPlugin/img/pfl-down-arrow.svg" aria-hidden="true">
        </button>
    </div>
 
    <div id="pfl-container" class="pfl-container">

        <div id="pfl-fact-table" class="pfl-tables" role="region">
 
            <h2 id="pfl-title" data-name="pfl-title">{translate key="plugins.generic.pfl.publicationFactsTitle"}</h2>
 
            <div role="table">
                <div role="row" class="pfl-header-row">
                    <div role="columnheader" class="pfl-sr-only"><span>{translate key="plugins.generic.pfl.metric"}</span></div>
                    <div role="columnheader" class="pfl-this-cell">{translate key="plugins.generic.pfl.thisArticle"}</div>
                    <div role="columnheader" class="pfl-other-cell">{translate key="plugins.generic.pfl.otherArticles"}</div>
                </div>
                <div role="row" class="pfl-body-row">
                    <div role="rowheader"class="pfl-bold">{translate key="plugins.generic.pfl.peerReviewers"}&nbsp;</div>
                    <div role="cell"class="pfl-this-cell pfl-bold">{translate key="plugins.generic.pfl.numPeerReviewers" peerReviewersUrl=$pflPeerReviewersUrl num=$pflReviewerCount|escape}</div>
                    <div role="cell" class="pfl-other-cell">{translate key="plugins.generic.pfl.averagePeerReviewers" num=$pflReviewerCountClass|escape}</div>
                </div>
            </div>

            <div class="pfl-indent pfl-body-row">
                <p>{translate key="plugins.generic.pfl.reviewerProfiles"}&nbsp;
                {translate key="common.notApplicableShort"}
                </p>
            </div>

            <h3 class="pfl-body-row">
                <div class="pfl-this-cell pfl-bold">{translate key="plugins.generic.pfl.authorStatements"}</div>
            </h3>

            <div role="table">
                <div role="row" class="pfl-header-row pfl-sr-only">
                    <div role="columnheader"><span>{translate key="plugins.generic.pfl.authorStatements"}</span></div>
                    <div role="columnheader">{translate key="plugins.generic.pfl.thisArticle"}</div>
                    <div role="columnheader">{translate key="plugins.generic.pfl.otherArticles"}</div>
                </div>
                <div role="row" class="pfl-body-row">
                    <div role="rowheader"class="pfl-indent">{translate key="plugins.generic.pfl.dataAvailability"}&nbsp;</div>
                    <div role="cell"class="pfl-this-cell">
                        {translate key="plugins.generic.pfl.dataAvailability.unsupported"}                    
                    </div>
                    <div role="cell"class="pfl-other-cell">{translate key="plugins.generic.pfl.averagePercentYes" num=$pflDataAvailabilityPercentClass}</div>
                </div>
                <div role="row" class="pfl-body-row">
                    <div role="rowheader" class="pfl-indent">{translate key="plugins.generic.pfl.funders"}&nbsp;</div>
                    <div role="cell"class="pfl-this-cell">
                        {if $pflFundingPluginEnabled}
                            {if $funderData}{* Provided by funding plugin when available *}
                                {translate key="plugins.generic.pfl.funders.yes"}
                            {else}
                                {translate key="plugins.generic.pfl.funders.no"}
                            {/if}
                        {else}
                            {translate key="common.notApplicableShort"}
                        {/if}
                    </div>
                    <div role="cell"class="pfl-other-cell">{translate key="plugins.generic.pfl.numHaveFunders" num=$pflNumHaveFundersClass}</div>
                </div>
                <div role="row" class="pfl-body-row">
                    <div role="rowheader"class="pfl-indent">{translate key="plugins.generic.pfl.competingInterests"}&nbsp;</div>
                    <div role="cell"class="pfl-this-cell">
                        {if $pflCompetingInterests}
                            {translate key="plugins.generic.pfl.competingInterests.yes"}
                        {elseif $pflCompetingInterestsEnabled}
                            {translate key="plugins.generic.pfl.competingInterests.no"}
                        {else}
                            {translate key="common.notApplicableShort"}
                        {/if}
                    </div>
                    <div role="cell"class="pfl-other-cell"> {translate key="plugins.generic.pfl.averagePercentYes" num=$pflCompetingInterestsPercentClass|escape}</div>
                </div>
            </div>

            <div role="table">
                <div role="row" class="pfl-header-row">
                    <div role="columnheader" class="pfl-sr-only"><span>{translate key="plugins.generic.pfl.metric"}</span></div>
                    <div role="columnheader" class="pfl-this-cell">{translate key="plugins.generic.pfl.forThisJournal"}</div>
                    <div role="columnheader" class="pfl-other-cell">{translate key="plugins.generic.pfl.otherJournals"}</div>
                </div>
                
                <div role="row" class="pfl-body-row">
                    <div role="rowheader"class="pfl-bold">{translate key="plugins.generic.pfl.articlesAccepted"}&nbsp;</div>
                    <div role="cell"class="pfl-this-cell pfl-bold">{translate key="plugins.generic.pfl.numArticlesAccepted" num=$pflAcceptedPercent|escape}</div>
                    <div role="cell" class="pfl-other-cell">{translate key="plugins.generic.pfl.numArticlesAcceptedShort" num=$pflNumAcceptedClass}</div>
                </div>
                
                <div role="row" class="pfl-body-row">
                    <div role="rowheader"class="pfl-indent">{translate key="plugins.generic.pfl.daysToPublication"}&nbsp;</div>
                    <div role="cell"class="pfl-this-cell">{translate key="plugins.generic.pfl.numDaysToPublication" num=$pflDaysToPublication|escape}</div>
                    <div role="cell" class="pfl-other-cell">{$pflDaysToPublicationClass|escape}</div>
                </div>
            </div>

            <div class="pfl-body-row">
                <h3 id="pfl-heading-indexed-in" class="pfl-bold">{translate key="plugins.generic.pfl.indexedIn"}</h3>
                <ul class="pfl-list-item" aria-labelledby="pfl-heading-indexed-in" role="list">
                    {capture assign="pflIndexListMarkup"}
                        {foreach from=$pflIndexList key=pflIndexListItemUrl item=pflIndexListItem}
                            <li><a href="{$pflIndexListItemUrl|escape}" target="_blank" aria-description="{$pflIndexListItem.description|escape}">{$pflIndexListItem.name|escape}</a></li>
                        {foreachelse}
                            &mdash;
                        {/foreach}
                    {/capture}
                        
                    {translate key="plugins.generic.pfl.indexedList" indexList=$pflIndexListMarkup}
                </ul>
            </div>

            <dl>

                <div class="pfl-body-row pfl-orcid-icon">
                    <dt class="pfl-bold">{translate key="plugins.generic.pfl.editorAndBoard"}</dt>
                    <dd class="pfl-list-item pfl-orcid-icon">
                        <img src="{$baseUrl}/plugins/generic/pflPlugin/img/orcid.svg" alt="ORCiD logo image" aria-hidden="true">
                        <a href="{url page="about" op="editorialTeam"}" target="_blank">{translate key="plugins.generic.pfl.profiles"}</a>
                    </dd>
                </div>

                <div class="pfl-body-row">
                    <dt class="pfl-indent">{translate key="plugins.generic.pfl.academicSociety"}&nbsp;</dt>
                    {capture assign="notApplicable"}{translate key="common.notApplicableShort"}{/capture}
                    <dd class="pfl-list-item" >{if $pflAcademicSocietyUrl}<a href="{$pflAcademicSocietyUrl|escape}" target="_blank">{/if}{$pflAcademicSociety|escape|default:$notApplicable}{if $pflAcademicSocietyUrl}</a>{/if}</dd>
                </div>

                {if $pflPublisherUrl or $pflPublisherName}
                  <div class="pfl-body-row">
                    <dt class="pfl-indent">{translate key="plugins.generic.pfl.publisher"}&nbsp;</dt>
                    <dd class="pfl-list-item">
                        {if $pflPublisherUrl}
                            <a href="{$pflPublisherUrl|escape}" target="_blank">{$pflPublisherName|escape|default:"&mdash;"}</a>
                        {else}
                            {$pflPublisherName|escape|default:"&mdash;"}
                        {/if}
                    </dd>
                  </div>
                {/if}

            </dl>

            <div id="pfl-table-footer">
                <p>{translate key="plugins.generic.pfl.informationFooter"} <a href="https://pkp.sfu.ca/information-on-pfl/"><img class="pfl-info-icon" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" alt="{translate key="plugins.generic.pfl.informationIcon"}"></a></p>
                <p>{translate key="plugins.generic.pfl.maintainedByPKP"}</p>
            </div>
        </div>
    </div>
</div>

</section>
