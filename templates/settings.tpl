{**
 * plugins/generic/pflPlugin/templates/settings.tpl
 *
 * Copyright (c) 2023 Simon Fraser University
 * Copyright (c) 2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Form to configure publication facts label plugin
 *
 *}
<script>
	$(function() {ldelim}
		// Attach the form handler.
		$('#pflPluginSettingsForm').pkpHandler('$.pkp.controllers.form.AjaxFormHandler');
	{rdelim});
</script>

<form class="pkp_form" id="pflPluginSettingsForm" method="post" action="{url router=$smarty.const.ROUTE_COMPONENT op="manage" category="generic" plugin=$pluginName verb="settings" save=true}">
	{csrf}
	{include file="controllers/notification/inPlaceNotification.tpl" notificationId="pflPluginSettingsFormNotification"}

	{if !$fundingPluginPresent}
		{fbvFormArea id="pflPluginSettings" title="plugins.generic.pflPlugin.fundingPluginMissing"}
			<p><strong>{translate key="plugins.generic.pflPlugin.fundingPluginMissing.description"}</strong></p>
		{/fbvFormArea}
	{/if}

	{fbvFormArea id="additionalJournalSettings" title="plugins.generic.pflPlugin.settings.journal"}
		{fbvElement type="text" id="academicSociety" value=$academicSociety label="plugins.generic.pfl.academicSociety.fieldLabel"}
		{fbvElement type="text" id="academicSocietyUrl" value=$academicSocietyUrl label="plugins.generic.pflPlugin.settings.academicSocietyUrl"}
	{/fbvFormArea}

	{fbvFormArea id="dateSettings" title="plugins.generic.pflPlugin.settings.excludePrior"}
		<div id="excludePriorDescription">{translate key="plugins.generic.pflPlugin.settings.dateStart.description"}</div>
		{fbvElement type="text" name="dateStart" id="dateStart" value=$dateStart label="plugins.generic.pflPlugin.settings.dateStart" size=$fbvStyles.size.SMALL inline=true class="datepicker"}
	{/fbvFormArea}

	{fbvFormArea id="pflPluginSettings" title="plugins.generic.pflPlugin.settings.indexes"}
		<div id="indexesDescription">{translate key="plugins.generic.pflPlugin.settings.indexes.description"}</div>
		<br />
		{fbvFormSection list="true" title="plugins.generic.pflPlugin.settings.indexes.automatic"}
			{fbvElement type="checkbox" id="includeDoaj" checked=$includeDoaj|default:false label="plugins.generic.pflPlugin.settings.indexes.automatic.doaj"}
			{fbvElement type="checkbox" id="includeScholar" checked=$includeScholar|default:false label="plugins.generic.pflPlugin.settings.indexes.automatic.scholar"}
			{fbvElement type="checkbox" id="includeLatindex" checked=$includeLatindex|default:false label="plugins.generic.pflPlugin.settings.indexes.automatic.latindex"}
			{fbvElement type="checkbox" id="includeMedline" name="includeMedline" checked=$includeMedline|default:false label="plugins.generic.pflPlugin.settings.indexes.automatic.medline"}
		{/fbvFormSection}

		{fbvFormSection title="plugins.generic.pflPlugin.settings.indexes.manual"}
			<ol>
				<li>
					{translate key="plugins.generic.pflPlugin.settings.indexes.manual.scopus"}
					<ol style="list-style-type: lower-alpha; padding-left: 2em;">
						<li>{translate key="plugins.generic.pflPlugin.settings.indexes.manual.scopus.step1"}</li>
						<li>{translate key="plugins.generic.pflPlugin.settings.indexes.manual.scopus.step2"}</li>
						<li>
							{translate key="plugins.generic.pflPlugin.settings.indexes.manual.scopus.step3"}
							{fbvElement type="text" id="scopusUrl" value=$scopusUrl label="common.url"}
						</li>
						<li>{translate key="plugins.generic.pflPlugin.settings.indexes.manual.scopus.step4"}</li>
					</ol>
				</li>
				<li>
					{translate key="plugins.generic.pflPlugin.settings.indexes.manual.wos"}
					<ol style="list-style-type: lower-alpha; padding-left: 2em;">
						<li>{translate key="plugins.generic.pflPlugin.settings.indexes.manual.wos.step1"}</li>
						<li>{translate key="plugins.generic.pflPlugin.settings.indexes.manual.wos.step2"}</li>
						<li>
							{translate key="plugins.generic.pflPlugin.settings.indexes.manual.wos.step3"}
							{fbvElement type="text" id="wosUrl" value=$wosUrl label="common.url"}
						</li>
						<li>{translate key="plugins.generic.pflPlugin.settings.indexes.manual.wos.step4"}</li>
					</ol>
				</li>
			</ol>
		{/fbvFormSection}
	{/fbvFormArea}

	{fbvFormButtons}
</form>
