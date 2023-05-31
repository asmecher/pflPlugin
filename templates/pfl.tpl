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
        <button id="pfl-button-open-facts" onclick="pflShowHideFactsLabel()" aria-controls="pfl-fact-table" aria-expanded="false">Publication Facts</button>
        <div id="pfl-fact-table" class="pfl-tables" role="region" tabindex="-1">
            <table>
                <caption class="sr-only">Publication Facts for journal</caption>
                <thead>
                    <tr>
                        <th>For This Journal</th>
                        <th>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg"></button>
                                <span>For other journals</span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button data-a11y-dialog-show="pfl-modal-publisher"><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg"></button> 
                                <span>Publisher:
                                    <span class="publisherName">{$currentJournal->getData('publisherInstitution')|escape|default:"—"}</span>
                                </span>
                            </div>
                        </td>
                        <td>—</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> 
                                <span>
                                    <a href="{url page="about" op="editorialTeam"}">Editorial Team</a> <img src="{$baseUrl}/plugins/generic/pflPlugin/img/orcid_16x16.gif" alt="ORCiD logo"> profiles
                                </span>
                            </div>
                        </td>
                        <td><span class="fake">83%</span> offer profiles</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> 
                                <span>Articles accepted: {$pflAcceptedPercent|escape}%</span>
                            </div>
                        </td>
                        <td><span class="fake">55%</span> accepted</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> 
                                <span>Indexed in <span class="fake">D DO GS</span></span>
                            </div>
                        </td>
                        <td><span class="fake">2.1</span> indexes average</td>
                    </tr>
                </tbody>
            </table>
            <table>
                <caption class="sr-only">Publication Facts for article</caption>
                <thead>
                    <tr>
                        <th>For this research article</th>
                        <th>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> 
                                <span>For other articles</span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="UPDATE to desriptive text!" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button>
                                <span><span class="fake">Peer reviewers</span>: {$pflReviewerCount|escape}</span>
                            </div>
                        </td>
                        <td><span class="fake">2.4</span> average</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="UPDATE to desriptive text!" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> 
                                <span>Competing interests: <span class="fake">Yes</span></span>
                            </div>
                        </td>
                        <td><span class="fake">11%</span> yes</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="UPDATE to desriptive text!" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> 
                                <span>Data availability: <span class="fake">Yes</span></span>
                            </div>
                        </td>
                        <td><span class="fake">32%</span> yes</td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pfl-flex">
                                <button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> 
                                <span>Funders: <span class="fake">NSF NIH WDP</span></span>
                            </div>
                        </td>
                        <td><span class="fake">68%</span> have funders</td>
                    </tr>
                </tbody>
            </table>
            <p class="pfl-table-footer">To learn more about a publication fact, click <a href=""><img class="info_icon" alt="Learn more about a publication fact." src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></a></p>
        </div>
    </div>


    <!-- Modals -->
    <!-- 1. Publication facts information-->
    <div
        id="pfl-modal-publisher"
        class="pfl-dialog-container"
        aria-labelledby="pfl-modal-title-publisher"
        aria-hidden="true"
        data-a11y-dialog="pfl-modal-publisher"
        >
        <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
        <div class="pfl-dialog-content" role="document">
            <button type="button" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="Close dialog">
            <span>Close</span> <img class="info_icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
            </button>
            <h1 id="pfl-modal-title-publisher">Publication Facts Information</h1>
            <hr/>
            <h2>For other journals</h2>
            <ul>
                <li>This column compiles data drawn from other journals that employ the Publication Facts Label.</li>
                <li>Currently limited to journals using Open Journal Systems as a publishing platform.</li>
                <li><span class="fake">List</span> of participating journals.</li>
                <li>Test.</li>
                <li>Test.</li>
            </ul>
            <p class="pfl-modal-footer">Learn more about the <span class="fake">Publication Facts Label</span>.</p>
        </div>
    </div>
</div>


