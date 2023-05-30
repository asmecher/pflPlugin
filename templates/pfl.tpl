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
<script
  defer
  src="https://cdn.jsdelivr.net/npm/a11y-dialog@7/dist/a11y-dialog.min.js"
></script>


<div class="publication_facts_label">

<input type="checkbox" id="pflCheckbox">
<label for="pflCheckbox" id="pflToggle">Publication Facts</label>
    <div class="pflContainer">
        <table>
            <caption>Publication Facts <span class="sr-only">for journal</span></caption>
            <thead class="forThisJournal">
                <tr class="forJournals">
                    <th class="forThisJournal">For This Journal</th>
                    <th class="forOtherJournals"><button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg"></button> For Other Journals</th>
                </tr>
            </thead>
            <tbody>
                <tr class="publisherInfo">
                    <td>
                        <span class="publisherLabel">
                        <button data-a11y-dialog-show="pfl-modal-publisher"><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg"></button> 
                            Publisher:</span>
                        <span class="publisherName">{$currentJournal->getData('publisherInstitution')|escape|default:"—"}</span>
                    </td>
                    <td>—</td>
                </tr>
                <tr class="editorialTeam">
                    <td>
                        <button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> <!-- Modal markup not added until the patterns are worked out -->
                        <a href="{url page="about" op="editorialTeam"}">Editorial Team</a> <img src="{$baseUrl}/plugins/generic/pflPlugin/img/orcid_16x16.gif" alt="ORCiD logo"> profiles</td>
                    <td><span class="fake">83%</span> offer profiles</td>
                </tr>
                <tr class="acceptance">
                    <td>
                        <!-- Modal markup not added until the patterns are worked out -->
                        <button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> <!-- Modal markup not added until the patterns are worked out -->

                        Articles accepted: {$pflAcceptedPercent|escape}%
                    </td>
                    <td><span class="fake">55%</span> accepted</td>
                </tr>
                <tr class="indexing">
                    <td>
                        <button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> <!-- Modal markup not added until the patterns are worked out -->
                        <!-- Modal markup not added until the patterns are worked out -->
                        Indexed in <span class="fake">D DO GS</span>
                    </td>
                    <td><span class="fake">2.1</span> indexes average</td>
                </tr>
            </tbody>
        </table>
        <table>
            <caption class="sr-only">Publication Facts for article</caption>
            <thead class="forThisResearchArticle">
                <tr class="researchArticle">
                    <th>For this research article</th>
                    <th>
                        <button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> <!-- Modal markup not added until the patterns are worked out -->
                        <!-- Modal markup not added until the patterns are worked out -->
                        For other articles
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr class="reviewers">
                    <td>
                        <!-- Modal markup not added until the patterns are worked out -->
                        <button><img class="info_icon" alt="UPDATE to desriptive text!" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> <!-- Modal markup not added until the patterns are worked out -->
                        <span class="fake">Peer reviewers</span>: {$pflReviewerCount|escape}
                    </td>
                    <td><span class="fake">2.4</span> average</td>
                </tr>
                <tr class="competingInterests">
                    <td>
                        <!-- Modal markup not added until the patterns are worked out -->
                        <button><img class="info_icon" alt="UPDATE to desriptive text!" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> <!-- Modal markup not added until the patterns are worked out -->
                        Competing interests: <span class="fake">Yes</span>
                    </td>
                    <td><span class="fake">11%</span> yes</td>
                </tr>
                <tr class="dataAvailability">
                    <td>
                        <!-- Modal markup not added until the patterns are worked out -->
                        <button><img class="info_icon" alt="UPDATE to desriptive text!" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> <!-- Modal markup not added until the patterns are worked out -->

                        Data availability: <span class="fake">Yes</span>
                    </td>
                    <td><span class="fake">32%</span> yes</td>
                </tr>
                <tr class="funders">
                    <td>
                        <button><img class="info_icon" alt="UPDATE to desriptive text" src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></button> 
                    <!-- Modal markup not added until the patterns are worked out -->
                        Funders: <span class="fake">NSF NIH WDP</span>
                    </td>
                    <td><span class="fake">68%</span> have funders</td>
                </tr>
            </tbody>
            </table>
            <p>To learn more about a publication fact, click <a href=""><img class="info_icon" alt="Learn more about a publication fact." src="{$baseUrl}/plugins/generic/pflPlugin/img/info_icon.svg" ></a></p>
    </div>
</div>


<!-- Modals -->
<!-- 1. The dialog container -->
<div
  id="pfl-modal-title-publisher"
  class="pfl-dialog-container"
  aria-labelledby="your-dialog-title-id"
  aria-hidden="true"
  data-a11y-dialog="pfl-modal-publisher"
>
  <!-- 2. The dialog overlay -->
  <div class="pfl-dialog-overlay" data-a11y-dialog-hide></div>
  <!-- 3. The actual dialog -->
  <div class="pfl-dialog-content" role="document">
    <!-- 4. The close button -->
    <button type="button" "dialog-close" class="pfl-dialog-close-button" data-a11y-dialog-hide aria-label="Close dialog">
      Close <img class="info_icon" alt="" src="{$baseUrl}/plugins/generic/pflPlugin/img/close_icon.svg" />
    </button>
    <!-- 5. The dialog title -->
    <h1 id="pfl-modal-title-publisher">Publication Facts Information</h1>
    <!-- 6. Dialog content -->
    <hr/>

    <h2>For other journals</h2>
    <ul>
        <li>This column compiles data drawn from other journals that employ the Publication Facts Label.</li>
        <li>Currently limited to journals using Open Journal Systems as a publishing platform.</li>
        <li><span class="fake">List</span> of participating journals.</li>
    </ul>
    <p class="pfl-modal-footer">Learn more about the <span class="fake">Publication Facts Label</span>.</p>
  </div>
</div>

