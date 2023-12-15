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
  font-family: 'Barlow-Black';
  src:  url('{$baseUrl}/plugins/generic/pflPlugin/font/Barlow-Black.woff2') format('woff2'),
        url('{$baseUrl}/plugins/generic/pflPlugin/font/Barlow-Black.woff') format('woff');
  font-weight: 900;
}

@font-face {
  font-family: 'Barlow-Bold';
  src:  url('{$baseUrl}/plugins/generic/pflPlugin/font/Barlow-Bold.woff2') format('woff2'),
        url('{$baseUrl}/plugins/generic/pflPlugin/font/Barlow-Bold.woff') format('woff');
  font-weight: 900;
}



@font-face {
  font-family: 'Archivo-Light';
  src:  url('{$baseUrl}/plugins/generic/pflPlugin/font/Archivo-Light.woff2') format('woff2'),
        url('{$baseUrl}/plugins/generic/pflPlugin/font/Archivo-Light.woff') format('woff');
}

@font-face {
  font-family: 'Archivo-Regular';
  src:  url('{$baseUrl}/plugins/generic/pflPlugin/font/Archivo-Regular.woff2') format('woff2'),
        url('{$baseUrl}/plugins/generic/pflPlugin/font/Archivo-Regular.woff') format('woff');
}

@font-face {
  font-family: 'Archivo-Medium';
  src:  url('{$baseUrl}/plugins/generic/pflPlugin/font/Archivo-Medium.woff2') format('woff2'),
        url('{$baseUrl}/plugins/generic/pflPlugin/font/Archivo-Medium.woff') format('woff');
}

</style>

<link rel="stylesheet" href="{$baseUrl}/plugins/generic/pflPlugin/css/pfl.css" type="text/css">
<!-- https://github.com/KittyGiraudel/a11y-dialog -->
<script
  defer
  src="{$baseUrl}/plugins/generic/pflPlugin/dist/pflplugin.iife.js"
></script>

<script>
    function pflShowHideFactsLabel() {

        var toggleButton = document.getElementById("pfl-button-open-facts");
        var ariaExpandedAttr = toggleButton.getAttribute("aria-expanded");
        if (ariaExpandedAttr == "false") {
            toggleButton.setAttribute("aria-expanded", "true")
            var toggleButton = document.getElementById("pfl-button-open-facts");
            var pflFactTable = document.getElementById("pfl-fact-table");
            var pflContainer = document.getElementById("pfl-container");
            pflContainer.classList.add("expanded");
            pflFactTable.style.display = "block";
            pflFactTable.focus();
        }
        else {
            toggleButton.setAttribute("aria-expanded","false");
            var pflFactTable = document.getElementById("pfl-fact-table");
            var pflContainer = document.getElementById("pfl-container");
            pflContainer.classList.remove("expanded");
            pflFactTable.style.display = "none";
        }
    }
</script>
<div class="publication-facts-label">
    <div id="pfl-container" class="pfl-container">
        <!-- following Example1 from https://www.w3.org/WAI/GL/wiki/Using_the_WAI-ARIA_aria-expanded_state_to_mark_expandable_and_collapsible_regions#Example_1:_Using_a_button_to_collapse_and_expand_a_region -->
        <button id="pfl-button-open-facts" onclick="pflShowHideFactsLabel()" aria-controls="pfl-fact-table" aria-expanded="false">{translate key="plugins.generic.pfl.publicationFacts"}</button>
        <div id="pfl-fact-table" class="pfl-tables" role="region" tabindex="-1">
            <table>
                <caption class="sr-only">{translate key="plugins.generic.pfl.factsForJournal"}</caption>
                <thead>
                    <tr>
                        <th>{translate key="plugins.generic.pfl.forThisJournal"}</th>
                        <th class="pfl-right-column">
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-for-other-journals"><img class="pfl-info-icon"  alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg"></button>
                                <span>{translate key="plugins.generic.pfl.forOtherJournals"}</span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="2">
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-publisher"><img class="pfl-info-icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg"></button>
                                <span>{translate key="plugins.generic.pfl.publisher"}
                                    <span class="publisherName">{if $pflPublisherUrl}<a href="{$pflPublisherUrl|escape}" target="_blank">{/if}{$pflPublisherName|escape|default:"&mdash;"}{if $pflPublisherUrl}</a>{/if}</span>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-editorial-team"><img class="pfl-info-icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span class="pfl-orcid-icon">
                                    {translate key="plugins.generic.pfl.editorialTeamProfiles" editorialTeamUrl=$pflEditorialTeamUrl orcidIconUrl=$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}
                                </span>
                            </div>
                        </td>
                        <td class="pfl-right-column">
                            <span class="pfl-orcid-icon">
                                {translate key="plugins.generic.pfl.numOfferProfiles" num=$pflNumOfferProfilesClass orcidIconUrl=$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}</td>
                            </span>
                        </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-articles-accepted"><img class="pfl-info-icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                {translate key="plugins.generic.pfl.numArticlesAccepted" num=$pflAcceptedPercent|escape} {*num=$pflAcceptedPercent|escape}*}
                            </div>
                        </td>
                        <td class="pfl-right-column">{translate key="plugins.generic.pfl.numArticlesAcceptedShort" num=$pflNumAcceptedClass}</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-indexes"><img class="pfl-info-icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                {capture assign="pflIndexListMarkup"}
                                  {foreach from=$pflIndexList item=pflIndexListItemName key=pflIndexListItemUrl}
                                    <a href="{$pflIndexListItemUrl|escape}" target-"_blank">{$pflIndexListItemName|escape}</a>
                                  {foreachelse}
                                    &mdash;
                                  {/foreach}
                                {/capture}
                                <span>{translate key="plugins.generic.pfl.indexedIn" indexList=$pflIndexListMarkup}</span>
                            </div>
                        </td>
                        <td class="pfl-right-column">{translate key="plugins.generic.pfl.numAverageIndexes" num=$pflNumIndexesClass}</td>
                    </tr>
                </tbody>
            </table>
            {if $article}
            <table>
                <caption class="sr-only">{translate key="plugins.generic.pfl.factsForArticle"}</caption>
                <thead>
                    <tr>
                        <th>{translate key="plugins.generic.pfl.forThisResearchArticle"}</th>
                        <th class="pfl-right-column">
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-for-other-articles"><img class="pfl-info-icon"  alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span>{translate key="plugins.generic.pfl.forOtherArticles"}</span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-peer-reviewers"><img class="pfl-info-icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span>{translate key="plugins.generic.pfl.numPeerReviewers" peerReviewersUrl=$pflPeerReviewersUrl num=$pflReviewerCount|escape}</span>
                            </div>
                        </td>
                        <td class="pfl-right-column">{translate key="plugins.generic.pfl.averagePeerReviewers" num=$pflReviewerCountClass}</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-competing-interests"><img class="pfl-info-icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span>
                                    {if $pflCompetingInterests}
                                        {translate key="plugins.generic.pfl.competingInterests.yes"}
                                    {else}
                                        {translate key="plugins.generic.pfl.competingInterests.no"}
                                    {/if}
                                </span>
                            </div>
                        </td>
                        <td class="pfl-right-column">{translate key="plugins.generic.pfl.percentYes" num=$pflCompetingInterestsPercentClass|escape}</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-data-availability"><img class="pfl-info-icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span>
                                    {if $pflDataAvailabilityUrl}
                                        {translate key="plugins.generic.pfl.dataAvailability.yes" dataAvailabilityUrl=$pflDataAvailabilityUrl}
                                    {else}
                                        {translate key="plugins.generic.pfl.dataAvailability.no"}
                                    {/if}
                                </span>
                            </div>
                        </td>
                        <td class="pfl-right-column">{translate key="plugins.generic.pfl.percentYes" num=$pflDataAvailabilityPercentClass}</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-funders"><img class="pfl-info-icon" alt="{translate key="plugins.generic.pfl.informationAlt"}" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span>
                                    {capture assign="pflFunderListMarkup"}
                                      {foreach from=$pflFunderList item=pflFunderListItemName key=pflFunderListItemUrl}
                                        <a href="{$pflFunderListItemUrl|escape}" target-"_blank">{$pflFunderListItemName|escape}</a>
                                      {/foreach}
                                    {/capture}
                                    {translate key="plugins.generic.pfl.funders" funderList=$pflFunderListMarkup}
                                </span>
                            </div>
                        </td>
                        <td class="pfl-right-column">{translate key="plugins.generic.pfl.numHaveFunders" num=$pflNumHaveFundersClass}</td>
                    </tr>
                </tbody>
            </table>
            {/if}{* If this is an article-specific page *}
            <p class="pfl-table-footer"><button data-a11y-dialog-show="pfl-modal-publication-facts-label">{translate key="plugins.generic.pfl.informationFooter" informationIcon=$baseUrl|concat:"/plugins/generic/pflPlugin/img/info_icon.svg"}</button></p>
        </div>
    </div>

    <!-- Modals -->
    <!-- Every modal needs:
        1) same unique id and data-a11y-dialog, which is in referenced by button with data-a11y-dialog-show attribute
        2) unique id for title (h1), which is referenced by aria-labelledby of the modal
    -->
    <!-- 1. Publication Facts Label  -->

    <div
        id="pfl-modal-publication-facts-label"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-publication-facts-label-title"
        aria-hidden="true"
    >
    <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-publication-facts-label-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            {translate key="plugins.generic.pfl.information.publicationFactsLabel"}
        </div>
    </div>

    <!-- For other journals -->
    <div
        id="pfl-modal-for-other-journals"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-for-other-journals-title"
        aria-hidden="true"
        >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-for-other-journals-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            {translate key="plugins.generic.pfl.information.forOtherJournals"}
            <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
        </div>
    </div>

    <!-- Publisher -->
    <div
        id="pfl-modal-publisher"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-publisher-title"
        aria-hidden="true"
    >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-publisher-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            {translate key="plugins.generic.pfl.information.publisher"}
            <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
        </div>
    </div>

    <!-- Editorial Team -->
    <div
        id="pfl-modal-editorial-team"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-editorial-team-title"
        aria-hidden="true"
    >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-editorial-team-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            {translate key="plugins.generic.pfl.information.editorialTeam" orcidIconUrl=$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}
            <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
        </div>
    </div>

  <!-- Articles accepted -->
  <div
    id="pfl-modal-articles-accepted"
    class="pfl-dialog-container"
    aria-labelledby="pfl-modal-articles-accepted-title"
    aria-hidden="true"
    >
    <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
    <div class="pfl-dialog-content" role="document">
        <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
        <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
        </button>
        <h1 id="pfl-modal-articles-accepted-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
        <hr/>
        {translate key="plugins.generic.pfl.information.articlesAccepted" orcidIconUrl=$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}
        <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
    </div>
    </div>

    <!-- Indexes -->
    <div
        id="pfl-modal-indexes"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-indexes-title"
        aria-hidden="true"
    >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-indexes-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            {translate key="plugins.generic.pfl.information.indexes"}
            <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
        </div>
    </div>

    <!-- For other articles -->
    <div
        id="pfl-modal-for-other-articles"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-for-other-articles-title"
        aria-hidden="true"
    >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-for-other-articles-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            {translate key="plugins.generic.pfl.information.forOtherArticles" }
            <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
        </div>
    </div>

    <!-- For Peer reviewers -->
    <div
        id="pfl-modal-peer-reviewers"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-peer-reviewers-title"
        aria-hidden="true"
    >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-peer-reviewers-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            {translate key="plugins.generic.pfl.information.peerReviewers" orcidIconUrl=$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}
            <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
        </div>
    </div>

    <!-- Competing interests -->
    <div
        id="pfl-modal-competing-interests"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-competing-interests-title"
        aria-hidden="true"
    >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-competing-interests-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            {translate key="plugins.generic.pfl.information.competingInterests"}
            <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
        </div>
    </div>

    <!-- Competing interests data -->
    <div
        id="pfl-modal-competing-interests-data"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-competing-interests-data-title"
        aria-hidden="true"
    >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-competing-interests-data-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            <h2>{translate key="plugins.generic.pfl.competingInterests"}</h2>
            <p>{translate key="plugins.generic.pfl.competingInterests.description"}</p>
            <ul>
              {if $pflCompetingInterests}{foreach from=$pflCompetingInterests item=competingInterest key=authorId}
                {foreach from=$publication->getData('authors') item=author}
                  {if $pflCompetingInterests[$author->getId()]}
                    <li><strong>{$author->getFullName()|escape}</strong>{$pflCompetingInterests[$author->getId()]|strip_unsafe_html}</li>
                  {/if}
                {/foreach}
              {/foreach}{/if}
              </li>
            </ul>
            <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
        </div>
    </div>

    <!-- Data availability -->
    <div
        id="pfl-modal-data-availability"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-data-availability-title"
        aria-hidden="true"
    >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-data-availability-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            {translate key="plugins.generic.pfl.information.dataAvailability" }
            <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
        </div>
    </div>

    <!-- Funders -->
    <div
        id="pfl-modal-funders"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-funders-title"
        aria-hidden="true"
    >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="{translate key="plugins.generic.pfl.closeLabel"}">
            <span>{translate key="plugins.generic.pfl.close"}</span> <img class="pfl-info-icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-funders-title">{translate key="plugins.generic.pfl.modalTitle"}</h1>
            <hr/>
            {translate key="plugins.generic.pfl.information.funders" }
            <p class="pfl-modal-footer">{translate key="plugins.generic.pfl.modalFooter"}</p>
        </div>
    </div>




</div>


