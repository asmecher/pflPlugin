{**
 * templates/pfl.tpl
 *
 * Copyright (c) 2023 Simon Fraser University
 * Copyright (c) 2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Journal Integrity Initiative Publication Facts Label template
 *}

 <!-- Moving font-face definition inside tpl, because baseUrl is not available in css -->
<style>
@font-face {
  font-family: 'Barlow-Bold';
  src:  url('{$baseUrl}/plugins/generic/pflPlugin/font/Barlow-Bold.woff2') format('woff2'),
        url('{$baseUrl}/plugins/generic/pflPlugin/font/Barlow-Bold.woff') format('woff');
  font-weight: 900;
}
@font-face {
  font-family: 'ArchivoNarrow-Variable';
  src:  url('{$baseUrl}/plugins/generic/pflPlugin/font/ArchivoNarrow-Variable.woff2') format('woff2'),
        url('{$baseUrl}/plugins/generic/pflPlugin/font/ArchivoNarrow-Variable.woff') format('woff');
}
</style>

<link rel="stylesheet" href="{$baseUrl}/plugins/generic/pflPlugin/css/pfl.css" type="text/css">
<!-- https://github.com/KittyGiraudel/a11y-dialog -->
<script
  defer
  src="{$baseUrl}/plugins/generic/pflPlugin/js/a11y-dialog.min.js"
></script>

<script>
    function pflShowHideFactsLabel() {

        var toggleButton = document.getElementById("pfl-button-open-facts");
        var ariaExpandedAttr = toggleButton.getAttribute("aria-expanded");
        if (ariaExpandedAttr == "false") {
            toggleButton.setAttribute("aria-expanded", "true")
            var toggleButton = document.getElementById("pfl-button-open-facts");
            var pflFactTable = document.getElementById("pfl-fact-table");
            pflFactTable.style.display = "block";
            pflFactTable.focus();
        }
        else {
            toggleButton.setAttribute("aria-expanded","false")
            var pflFactTable = document.getElementById("pfl-fact-table");
            pflFactTable.style.display = "none";

        }
    }
</script>
<div class="publication-facts-label">

    <div class="pfl-container">
        <!-- following Example1 from https://www.w3.org/WAI/GL/wiki/Using_the_WAI-ARIA_aria-expanded_state_to_mark_expandable_and_collapsible_regions#Example_1:_Using_a_button_to_collapse_and_expand_a_region -->
        <button id="pfl-button-open-facts" onclick="pflShowHideFactsLabel()" aria-controls="pfl-fact-table" aria-expanded="false">{translate key="plugins.generic.pfl.publicationFacts"}</button>
        <div id="pfl-fact-table" class="pfl-tables" role="region" tabindex="-1">
            <table>
                <caption class="sr-only">{translate key="plugins.generic.pfl.factsForJournal"}</caption>
                <thead>
                    <tr>
                        <th>{translate key="plugins.generic.pfl.forThisJournal"}</th>
                        <th>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg"></button>
                                <span>{translate key="plugins.generic.pfl.forOtherJournals"}</span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-publisher"><img class="info_icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg"></button>
                                <span>{translate key="plugins.generic.pfl.publisher"}
                                    <span class="publisherName">{$currentJournal->getData('publisherInstitution')|escape|default:"—"}</span>
                                </span>
                            </div>
                        </td>
                        <td>—</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span>
                                    {capture assign="editorialTeamUrl"}{url page="about" op="editorialTeam"}{/capture}
                                    {translate key="plugins.generic.pfl.editorialTeamProfiles" editorialTeamUrl=$editorialTeamUrl orcidIconUrl=$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid_16x16.gif"}
                                </span>
                            </div>
                        </td>
                        <td>{translate key="plugins.generic.pfl.numOfferProfiles" num="<span class=\"fake\">83%</span>"}</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                {translate key="plugins.generic.pfl.numArticlesAccepted" num=$pflAcceptedPercent|escape}
                            </div>
                        </td>
                        <td>{translate key="plugins.generic.pfl.numArticlesAcceptedShort" num="<span class=\"fake\">55%</span>"}</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span>{translate key="plugins.generic.pfl.indexedIn" indexList="<span class=\"fake\">D DO GS</span>"}</span>
                            </div>
                        </td>
                        <td>{translate key="plugins.generic.pfl.numAverageIndexes" num="<span class=\"fake\">2.1</span>"}</td>
                    </tr>
                </tbody>
            </table>
            <table>
                <caption class="sr-only">{translate key="plugins.generic.pfl.factsForArticle"}</caption>
                <thead>
                    <tr>
                        <th>{translate key="plugins.generic.pfl.forThisResearchArticle"}</th>
                        <th>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span>{translate key="plugins.generic.pfl.forOtherArticles"}</span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span><span class="fake">{translate key="plugins.generic.pfl.numPeerReviewers" num=$pflReviewerCount|escape}</span></span>
                            </div>
                        </td>
                        <td>{translate key="plugins.generic.pfl.averagePeerReviewers" num="<span class=\"fake\">55%</span>"}</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span><span class="fake">{translate key="plugins.generic.pfl.competingInterests.yes"}</span></span>
                            </div>
                        </td>
                        <td>{translate key="plugins.generic.pfl.numYes" num="<span class=\"fake\">11%</span>"}</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span><span class="fake">{translate key="plugins.generic.pfl.dataAvailability.yes"}</span></span>
                            </div>
                        </td>
                        <td>{translate key="plugins.generic.pfl.numYes" num="<span class=\"fake\">32%</span>"}</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span>{translate key="plugins.generic.pfl.funders" funderList="<span class=\"fake\">NSF NIH WDP</span>"}</span>
                            </div>
                        </td>
                        <td>{translate key="plugins.generic.pfl.numHaveFunders" num="<span class=\"fake\">68%</span>"}</td>
                    </tr>
                </tbody>
            </table>
            <p class="pfl-table-footer">{translate key="plugins.generic.pfl.informationFooter" informationIcon=$baseUrl|concat:"/plugins/generic/pflPlugin/img/info_icon.svg"}</p>
        </div>
    </div>


    <!-- Modals -->
    <!-- Every modal needs:
        1) same unique id and data-a11y-dialog, which is in referenced by button with data-a11y-dialog-show attribute
        2) unique id for title (h1), which is referenced by aria-labelledby of the modal
    -->
    <!-- 1. Publication facts information-->
    <div
        id="pfl-modal-publisher"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-publisher-title"
        aria-hidden="true"
        data-a11y-dialog="pfl-modal-publisher"
        >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>Close</span> <img class="info_icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-publisher-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            {translate key="plugins.generic.pfl.information.forOtherJournals"}
            <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
        </div>
    </div>
</div>


