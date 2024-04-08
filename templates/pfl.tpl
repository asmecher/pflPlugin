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
             var inputElement = document.querySelector(".dropdown .textBox");
             pflContainer.classList.add("expanded");
             inputElement.classList.add("expanded");
             inputElement.setAttribute("placeholder", "");
             pflFactTable.style.display = "block";
             // pflFactTable.focus();
         }
         else {
             toggleButton.setAttribute("aria-expanded","false");
             var pflFactTable = document.getElementById("pfl-fact-table");
             var pflContainer = document.getElementById("pfl-container");
             var inputElement = document.querySelector(".dropdown .textBox");
             pflContainer.classList.remove("expanded");
             inputElement.classList.remove("expanded");
             inputElement.setAttribute("placeholder", "Publication Facts Label");
             pflFactTable.style.display = "none";
         }
     }
 </script>
 
 
 
 <div class="publication-facts-label">
 
     <button id="pfl-button-open-facts" onclick="pflShowHideFactsLabel()" aria-controls="pfl-fact-table" aria-expanded="false" aria-label="Publication Facts Label">
 
     <div class="dropdown">
         <input type="text" class="textBox"
         placeholder="Publication Facts Label" readonly>
     </div>
 
     </button>
 
 
     <div id="pfl-container" class="pfl-container">
 
 
         <div id="pfl-fact-table" class="pfl-tables" role="region" tabindex="-1">
 
             <svg id="pfl-title" data-name="pfl-title" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 312 28.16">
             <path class="pfl-title" d="M8.39,27.24H.24V.98h10.71c2.56,0,5.43.08,7.69,1.38,2.45,1.45,3.9,4.06,3.9,6.89,0,2.49-.96,4.86-2.91,6.43-2.03,1.65-4.63,2.03-7.16,2.03h-4.1v9.53ZM10.49,12.08c1.84,0,4.06-.12,4.06-2.56s-1.99-2.53-3.83-2.53h-2.33v5.09h2.1Z"></path>
             <path class="pfl-title" d="M36.23,27.24v-3.21h-.08c-.8,2.53-3.41,3.6-5.93,3.6-1.61,0-3.18-.38-4.36-1.49-1.38-1.38-1.53-3.1-1.53-4.94V7.68h7.58v11.83c0,1.26-.04,2.6,1.68,2.6.77,0,1.49-.42,1.84-1.11.34-.65.38-1.34.38-2.07V7.68h7.58v19.56h-7.16Z"></path>
             <path class="pfl-title" d="M46.3.98h7.58v9.03h.11c1.07-1.99,2.72-2.72,5.01-2.72,5.47,0,7.35,5.24,7.35,9.91,0,5.43-2.3,10.41-8.42,10.41-2.6,0-4.78-.92-6.28-3.06-.46.84-.77,1.76-1.03,2.68h-4.32V.98ZM53.91,19.47c0,1.53.19,3.41,2.18,3.41,2.6,0,2.53-3.48,2.53-5.36s.12-5.36-2.6-5.36c-.69,0-1.22.34-1.65.88-.54.65-.46,1.26-.46,2.07v4.36Z"></path>
             <path class="pfl-title" d="M75.76,27.24h-7.58V.98h7.58v26.25Z"></path>
             <path class="pfl-title" d="M86.09,5.81h-7.58V.6h7.58v5.2ZM86.09,27.24h-7.58V7.68h7.58v19.56Z"></path>
             <path class="pfl-title" d="M108.03,19.89c-.69,5.05-4.29,7.73-9.26,7.73-2.83,0-5.13-.65-7.19-2.68-1.99-1.99-2.91-4.63-2.91-7.42,0-5.89,4.06-10.22,10.06-10.22,4.82,0,8.65,2.83,9.22,7.73l-6.7.57-.04-.19c-.27-1.34-.57-2.87-2.26-2.87-2.41,0-2.41,3.18-2.41,4.9,0,1.84.04,4.82,2.53,4.82,1.65,0,2.26-1.49,2.45-2.91l6.51.54Z"></path>
             <path class="cls-1" d="M122.61,27.24c-.19-.88-.27-1.8-.27-2.72-1.53,2.26-3.71,3.1-6.39,3.1-3.64,0-6.81-1.99-6.81-5.89,0-3.1,2.41-5.17,5.13-6.01,2.49-.77,5.13-1.07,7.69-1.22v-.15c0-1.76-.46-2.45-2.3-2.45-1.49,0-2.76.54-2.99,2.18l-6.96-.65c1.15-4.86,5.78-6.12,10.18-6.12,2.3,0,5.24.31,7.16,1.68,2.56,1.8,2.26,4.32,2.26,7.12v6.85c0,1.45.04,2.91.61,4.29h-7.31ZM121.96,18.09c-1.84.19-4.9.77-4.9,3.14,0,1.26.8,1.8,1.99,1.8,2.87,0,2.91-2.41,2.91-4.55v-.38Z"></path>
             <path class="cls-1" d="M140.88,7.68h3.9v4.98h-3.83v6.74c0,1.42-.15,2.53,1.65,2.53.73,0,1.45-.15,2.18-.34v5.47c-1.84.46-4.17.65-5.24.65-1.76,0-3.41-.65-4.71-2.07-1.49-1.61-1.45-3.48-1.45-5.59v-7.39h-2.83v-4.98h3.18l.57-6.24,6.58-.23v6.47Z"></path>
             <path class="cls-1" d="M155.3,5.81h-7.58V.6h7.58v5.2ZM155.3,27.24h-7.58V7.68h7.58v19.56Z"></path>
             <path class="cls-1" d="M179.37,17.63c0,5.93-4.78,9.99-10.75,9.99s-10.75-4.06-10.75-9.99c0-6.28,4.63-10.33,10.75-10.33s10.75,4.06,10.75,10.33ZM165.98,17.36c0,5.24,1.26,5.62,2.64,5.62s2.64-.38,2.64-5.62c0-1.88-.04-5.28-2.64-5.28s-2.64,3.41-2.64,5.28Z"></path>
             <path class="cls-1" d="M181.65,7.68h7.16v2.76h.08c.92-2.22,3.18-3.14,5.55-3.14,1.84,0,3.94.54,5.09,2.03,1.22,1.61,1.22,3.83,1.22,5.86v12.05h-7.58v-11.86c0-1.19,0-2.83-1.65-2.83-2.1,0-2.3,1.8-2.3,3.41v11.29h-7.58V7.68Z"></path>
             <path class="cls-1" d="M223.62,17.4v9.83h-7.84V.98h18.98v6.24h-11.14v4.29h8.53v5.89h-8.53Z"></path>
             <path class="cls-1" d="M247.33,27.24c-.19-.88-.27-1.8-.27-2.72-1.53,2.26-3.71,3.1-6.39,3.1-3.64,0-6.81-1.99-6.81-5.89,0-3.1,2.41-5.17,5.13-6.01,2.49-.77,5.13-1.07,7.69-1.22v-.15c0-1.76-.46-2.45-2.3-2.45-1.49,0-2.75.54-2.98,2.18l-6.96-.65c1.15-4.86,5.78-6.12,10.18-6.12,2.3,0,5.24.31,7.16,1.68,2.56,1.8,2.26,4.32,2.26,7.12v6.85c0,1.45.04,2.91.61,4.29h-7.31ZM246.68,18.09c-1.84.19-4.9.77-4.9,3.14,0,1.26.8,1.8,1.99,1.8,2.87,0,2.91-2.41,2.91-4.55v-.38Z"></path>
             <path class="cls-1" d="M275.4,19.89c-.69,5.05-4.29,7.73-9.26,7.73-2.83,0-5.13-.65-7.19-2.68-1.99-1.99-2.91-4.63-2.91-7.42,0-5.89,4.06-10.22,10.06-10.22,4.82,0,8.65,2.83,9.22,7.73l-6.7.57-.04-.19c-.27-1.34-.57-2.87-2.26-2.87-2.41,0-2.41,3.18-2.41,4.9,0,1.84.04,4.82,2.53,4.82,1.65,0,2.26-1.49,2.45-2.91l6.51.54Z"></path>
             <path class="cls-1" d="M286.26,7.68h3.9v4.98h-3.83v6.74c0,1.42-.15,2.53,1.65,2.53.73,0,1.45-.15,2.18-.34v5.47c-1.84.46-4.17.65-5.24.65-1.76,0-3.41-.65-4.71-2.07-1.49-1.61-1.45-3.48-1.45-5.59v-7.39h-2.83v-4.98h3.18l.57-6.24,6.58-.23v6.47Z"></path>
             <path class="cls-1" d="M297.58,20.88c.42,1.88,2.53,2.1,4.17,2.1.77,0,2.91-.08,2.91-1.22,0-1-2.6-1.19-3.29-1.26-4.09-.57-8.96-1.38-8.96-6.58,0-2.22,1.19-3.98,3.02-5.13,1.91-1.19,4.09-1.49,6.28-1.49,3.67,0,7.54,1.42,8.84,5.09l-5.78,1.11c-.57-1.34-2.07-1.72-3.41-1.72s-2.45.46-2.45,1.03c0,.61.54.84,1.15,1,.84.23,2.37.34,3.29.46,1.76.23,3.79.46,5.32,1.46,1.8,1.15,2.75,2.87,2.75,4.97,0,5.4-5.7,6.93-10.1,6.93s-8.38-1.42-9.83-5.93l6.08-.8Z"></path>
             </svg>
 
     
 
             {if $article}
 
 
         
             <table>
             
                 <caption class="sr-only">{translate key="plugins.generic.pfl.factsForArticle"}</caption>
 
 
                     <thead>
                         <tr>
                             <th>
                                 <div class="pfl-flex-theader">
                                     <span>{translate key="plugins.generic.pfl.thisArticle"}</span>
                                     <span>{translate key="plugins.generic.pfl.otherArticles"}</span>
                                 </div>
                             </th>
                         </tr>
                     </thead>
 
 
 
                     <tbody>
 
                         <tr>
                             <td>
                                 <div class="pfl-flex-bold">
                                     <span>{translate key="plugins.generic.pfl.numPeerReviewers" peerReviewersUrl=$pflPeerReviewersUrl num=$pflReviewerCount|escape}</span>
                                 </div>
                                 <div class="pfl-flex">
                                     <span>{translate key="plugins.generic.pfl.averagePeerReviewers" num=$pflReviewerCountClass}</span>
                                 </div>
                             </td>
                         </tr>
 
 
                         
                         <tr>
                             <td>
                                 <div class="pfl-flex">
                                     <span class="pfl-orcid-icon">
                                         {translate key="plugins.generic.pfl.reviewerProfiles" editorialTeamUrl=$pflEditorialTeamUrl orcidIconUrl=$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}
                                     </span>
                                 </div>
                             </td>
                         </tr>
 
 
 
                         <tr>
                             <td>
                                 <div class="pfl-flex-bold">
                                 <span>{translate key="plugins.generic.pfl.authorStatements"}</span>
                                 </div>
                             </td>
                         </tr>
 
 
 
                         <tr>
                             <td>
                                     <span class="pfl-flex">
                                         {if $pflDataAvailabilityUrl}
                                             {translate key="plugins.generic.pfl.dataAvailability.yes" dataAvailabilityUrl=$pflDataAvailabilityUrl}
                                         {else}
                                             {translate key="plugins.generic.pfl.dataAvailability.no"}
                                         {/if}
                                     </span>
 
                                     <span>
                                     {translate key="plugins.generic.pfl.percentYes" num=$pflDataAvailabilityPercentClass}
                                     </span>
 
                             </td>
                         </tr>
 
 
 
                         <tr>
                             <td>
                                     <span class="pfl-flex">
                                         {if $pflFunderList}
                                             {translate key="plugins.generic.pfl.funders.yes" pflFunderList=$pflpflNumHaveFundersClass}
                                         {else}
                                             {translate key="plugins.generic.pfl.funders.no"}
                                         {/if}
                                     </span>
 
                                     <span>
                                         {translate key="plugins.generic.pfl.numHaveFunders" num=$pflNumHaveFundersClass}
                                     </span>
 
                             </td>
                         </tr>   
 
 
 
                         <tr>
                             <td>
                                 <span class="pfl-flex">
                                     {if $pflCompetingInterests}
                                         {translate key="plugins.generic.pfl.competingInterests.yes"}
                                     {else}
                                         {translate key="plugins.generic.pfl.competingInterests.no"}
                                     {/if}
                                 </span>
 
                                 <span>
                                 {translate key="plugins.generic.pfl.percentYes" num=$pflCompetingInterestsPercentClass|escape}
                                 </span>
                             </td>
                         </tr>
 
                     </tbody>
 
             </table>
 
 
 
 
             {/if} {* If this is an article-specific page *}
 
 
 
 
             <table>
                 <caption class="sr-only">{translate key="plugins.generic.pfl.factsForJournal"}</caption>
                 
                 <thead>
                     <tr>
                         <th>
                             <div class="pfl-flex-theader">
                                 <span>{translate key="plugins.generic.pfl.forThisJournal"}</span>
                                 <span>{translate key="plugins.generic.pfl.otherJournals"}</span>
                             </div>
                         </th>
                     </tr>
                 </thead>
 
                 <tbody>
 
                     <tr>
                         <td>
                             <span class="pfl-flex-bold">{translate key="plugins.generic.pfl.numArticlesAccepted" num=$pflAcceptedPercent|escape}</span>
                             <span>{translate key="plugins.generic.pfl.numArticlesAcceptedShort" num=$pflNumAcceptedClass}</span>
                         </td>
                     </tr>
 
 
 
                     {* Didn't find the corresponding translate key in the locale.po file *}
                     <tr>
                         <td>
                             <span class="pfl-flex">Days to publication: 134</span>
                             <span>145</span>
                         </td>
                     </tr>
                     
 
 
                     <tr>
                         <td>
                             <div class="pfl-flex-bold">
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
                     </tr>
 
 
 
                     {* Inserted the same translçate key as "Reviewer profiles" row *}
                     <tr>
                         <td>
                             <div class="pfl-flex-bold">
                                 <span class="pfl-orcid-icon">
                                     {translate key="plugins.generic.pfl.editorAndBoardMemberProfiles" editorialTeamUrl=$pflEditorialTeamUrl orcidIconUrl=$baseUrl|concat:"/plugins/generic/pflPlugin/img/orcid.svg"}
                                 </span>
                             </div>
                         </td>
                     </tr>
 
 
 
 
                     
                     <tr>
                         <td>
                             <div class="pfl-flex">
                                 <span>{translate key="plugins.generic.pfl.academicSociety"}</span>
                             </div>
                         </td>
                     </tr>
 
 
 
                     <tr>
                         <td>
                             <div class="pfl-flex">
                                 <span>{translate key="plugins.generic.pfl.publisher"}
                                     <span class="publisherName">{if $pflPublisherUrl}<a href="{$pflPublisherUrl|escape}" target="_blank">{/if}{$pflPublisherName|escape|default:"&mdash;"}{if $pflPublisherUrl}</a>{/if}</span>
                                 </span>
                             </div>
                         </td>
                     </tr>
 
                 </tbody>
             </table>
 
 
 
             <div class="pfl-table-footer">
                 <button>{translate key="plugins.generic.pfl.informationFooter"} <a href="{$baseUrl}/plugins/generic/pflPlugin/templates/info_PFL.html" target="_blank"> <img class="pfl-info-icon" alt="Learn more about a publication fact." src="{$baseUrl|concat:'/plugins/generic/pflPlugin/img/info_icon.svg'}"></a></button>
                 <p>{translate key="plugins.generic.pfl.maintainedByPKP"}</p>
             </div>
 
         </div>
 
     </div>
 
 </div>
 