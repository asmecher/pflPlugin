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
<div class="publication_facts_label">

<input type="checkbox" id="pflCheckbox">
<label for="pflCheckbox" id="pflToggle">Publication Facts</label>

<table>
    <tr>
        <th colspan="2"><label for="pflCheckbox">Publication Facts</label></th>
    </tr>
    <tbody class="forThisJournal">
        <tr class="forJournals">
            <td class="forThisJournal">For This Journal</td>
            <td class="forOtherJournals">ℹ️ For Other Journals</td>
        </tr>
        <tr class="publisherInfo">
            <td>
                <span class="publisherLabel">
                    <span class="pfl_popover">
                        <label for="publisherLabelCheckbox">ℹ️</label>
                        <input type="checkbox" id="publisherLabelCheckbox">
                        <div class="pfl_popover_content">
                            <label class="pfl_close_label" for="publisherLabelCheckbox">Close</label>
                            <h3>Publication Facts Information</h3>
                            <h4>For other journals<h4>
                            <ul>
                                <li>This column compiles data drawn from other journals that employ the Publication Facts Label.</li>
                                <li>Currently limited to journals using Open Journal Systems as a publishing platform.</li>
                                <li><span class="fake">List</span> of participating journals.</li>
                            </ul>
                            <span class="pfl_popover_footer">Learn more about the <span class="fake">Publication Facts Label</span>.</span>
                        </div>
                    </span>
                    Publisher:</span>
                <span class="publisherName">{$currentJournal->getData('publisherInstitution')|escape|default:"—"}</span>
            </td>
            <td>—</td>
        </tr>
        <tr class="editorialTeam">
            <td>
                ℹ️ <!-- Modal markup not added until the patterns are worked out -->
                <a href="{url page="about" op="editorialTeam"}">Editorial Team</a> <img src="{$baseUrl}/plugins/generic/pflPlugin/img/orcid_16x16.gif" alt="ORCiD logo"> profiles</td>
            <td><span class="fake">83%</span> offer profiles</td>
        </tr>
        <tr class="acceptance">
            <td>
                ℹ️<!-- Modal markup not added until the patterns are worked out -->
                Articles accepted: {$pflAcceptedPercent|escape}%
            </td>
            <td><span class="fake">55%</span> accepted</td>
        </tr>
        <tr class="indexing">
            <td>
                ℹ️<!-- Modal markup not added until the patterns are worked out -->
                Indexed in <span class="fake">D DO GS</span>
            </td>
            <td><span class="fake">2.1</span> indexes average</td>
        </tr>
    </tbody>
    <tbody class="forThisResearchArticle">
        <tr class="researchArticle">
            <td>For this research article</td>
            <td>
                ℹ️<!-- Modal markup not added until the patterns are worked out -->
                For other articles
            </td>
        </tr>
        <tr class="reviewers">
            <td>
                ℹ️<!-- Modal markup not added until the patterns are worked out -->
                <span class="fake">Peer reviewers</span>: {$pflReviewerCount|escape}
            </td>
            <td><span class="fake">2.4</span> average</td>
        </tr>
        <tr class="competingInterests">
            <td>
                ℹ️<!-- Modal markup not added until the patterns are worked out -->
                Competing interests: <span class="fake">Yes</span>
            </td>
            <td><span class="fake">11%</span> yes</td>
        </tr>
        <tr class="dataAvailability">
            <td>
                ℹ️<!-- Modal markup not added until the patterns are worked out -->
                Data availability: <span class="fake">Yes</span>
            </td>
            <td><span class="fake">32%</span> yes</td>
        </tr>
        <tr class="funders">
            <td>
                ℹ️<!-- Modal markup not added until the patterns are worked out -->
                Funders: <span class="fake">NSF NIH WDP</span>
            </td>
            <td><span class="fake">68%</span> have funders</td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="2">To learn more about a publication fact, click ℹ️</td>
        </tr>
    </tfoot>
</table>
</div>
