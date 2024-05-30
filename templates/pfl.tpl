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
            const highlightDropdown = document.querySelector(".pfl-dropdown");
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
 
    <div class="pfl-dropdown">
        <button id="pfl-button-open-facts" aria-controls="pfl-fact-table" aria-expanded="false">
            <span id="buttonText">{translate key="plugins.generic.pfl.publicationFacts"}</span>
        </button>
    </div>
 
    <div id="pfl-container" class="pfl-container">

        <div id="pfl-fact-table" class="pfl-tables" role="region" tabindex="-1">
 
            <h2 id="pfl-title" data-name="pfl-title">{translate key="plugins.generic.pfl.publicationFactsTitle"}</h2>
 
            {if $article}
            <div role="table">
                <div role="row" class="header-row">
                    <div role="columnheader"><span class="pfl-sr-only">Metric</span></div>
                    <div role="columnheader">{translate key="plugins.generic.pfl.thisArticle"}</div>
                    <div role="columnheader">{translate key="plugins.generic.pfl.otherArticles"}</div>
                </div>
                <div role="row">
                    <div role="rowheader">Peer reviewers</div>
                    <div role="cell">2</div>
                    <div role="cell">2.4</div>
                </div>
            </div>

            {* $editorialTeamUrl doesn't seem to point to the correct place inside the template *}

            <div class="pfl-list-item">
                <div class="pfl-indent">
                    <p class="pfl-orcid-icon">{translate key="plugins.generic.pfl.reviewerProfiles_01"}

                        <img src="{$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}" alt="ORCiD logo image">

                        <a href="{$editorialTeamUrl}" target="_blank">{translate key="plugins.generic.pfl.profiles"} </a>

                    </p>
                </div>
            </div>

            <h3 class="pfl-list-item pfl-paragraph-item">
                <div class="pfl-table-cells-left">{translate key="plugins.generic.pfl.authorStatements"}</div>
            </h3>

            <div role="table">
                <div role="row" class="header-row">
                    <div role="columnheader"><span class="pfl-sr-only">Author statement</span></div>
                    <div role="columnheader">{translate key="plugins.generic.pfl.thisArticle"}</div>
                    <div role="columnheader">{translate key="plugins.generic.pfl.otherArticles"}</div>
                </div>
                <div role="row">
                    <div role="rowheader">Data availability</div>
                    <div role="cell">No</div>
                    <div role="cell">16%</div>
                </div>
                <div role="row">
                    <div role="rowheader">External Funding</div>
                    <div role="cell">No</div>
                    <div role="cell">32%</div>
                </div>
                <div role="row">
                    <div role="rowheader">Competing interests</div>
                    <div role="cell">No</div>
                    <div role="cell">11%</div>
                </div>
            </div>
            {/if} {* If this is an article-specific page *}

            <table>
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
                        <td class="pfl-table-cells-left">
                            {translate key="plugins.generic.pfl.numArticlesAccepted" num=$pflAcceptedPercent|escape}
                        </td>
                        <td class="pfl-table-cells-right">
                            {translate key="plugins.generic.pfl.numArticlesAcceptedShort" num=$pflNumAcceptedClass}
                        </td>
                    </tr>

                    {* Dynamic count numbers missing here *}

                    <tr class="pfl-list-item">
                        <td class="pfl-indent" >
                            {translate key="plugins.generic.pfl.daysToPublication"} {$pflDaysToPublication|escape}
                        </td>
                        <td class="pfl-right-align">
                            {$pflDaysToPublicationClass|escape}
                        </td>
                    </tr>
                </tbody>
            </table>
            <h3 id="pfl-heading-indexed-in">Indexed in</h3>
            <ul class="pfl-list-item pfl-paragraph-item" aria-labelledby="pfl-heading-indexed-in" role="list">
                {capture assign="pflIndexListMarkup"}

                    {foreach from=$pflIndexList item=pflIndexListItemName key=pflIndexListItemUrl}
                        <li><a href="{$pflIndexListItemUrl|escape}" target="_blank">{$pflIndexListItemName|escape}</a></li>

                    {foreachelse}
                        &mdash;

                    {/foreach}
                    {/capture}
                    
                {translate key="plugins.generic.pfl.indexedIn" indexList=$pflIndexListMarkup}
            </ul>

            <dl>
                <dt class="pfl-list-item pfl-paragraph-item">
                    {translate key="plugins.generic.pfl.editorAndBoardMembers"}
                </dt>
                <dd>
                    <img src="{$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}" alt="ORCiD logo image">

                    <a href="{$editorialTeamUrl}" target="_blank">{translate key="plugins.generic.pfl.profiles"}</a>

                </dd>


                <dt class="pfl-list-item">
                    <div class="pfl-indent">
                        {translate key="plugins.generic.pfl.academicSociety"}
                    </div>
                </dt>
                <dd>
                    <a href="" target="_blank">N/A</a>
                </dd>

                {if $pflPublisherUrl or $pflPublisherName} 
                    <dt class="pfl-last">
                        <div class="pfl-indent">
                                {translate key="plugins.generic.pfl.publisher"}

                        </div>
                    </dt>
                    <dd>
                        {if $pflPublisherUrl}
                            <a href="{$pflPublisherUrl|escape}" target="_blank">
                                {$pflPublisherName|escape|default:"&mdash;"}
                            </a>
                        {else}
                            {$pflPublisherName|escape|default:"&mdash;"}
                        {/if}
                    </dd>
                {/if}

            </dl>

            <div id="pfl-table-footer">
                <a id="pfl-table-footer-info-link" href="{url page="publicationFacts"}" target="_blank"> {translate key="plugins.generic.pfl.informationFooter"} <img class="pfl-info-icon" src="{$baseUrl|concat:'/plugins/generic/pflPlugin/img/info_icon.svg'}"></a>
                <p  {translate key="plugins.generic.pfl.maintainedByPKP"}<a href="https://pkp.sfu.ca" target="_blank">Public Knowledge Project</a></p>
            </div>

        </div>

    </div>

</div>
 
