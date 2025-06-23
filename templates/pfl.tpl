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

<publication-facts-label></publication-facts-label>

<!-- Load the web component JavaScript -->
<script>
  // Wait for the component to be defined
  window.addEventListener("DOMContentLoaded", () => {
    const pfl = document.querySelector("publication-facts-label");

    /* Funder data are available only in the template, therefore the value is calculated here*/
    const funderData = {$funderData|json_encode};
    const pflFundingPluginEnabled = {$pflFundingPluginEnabled|json_encode};

    let pflFundersValue = null;
    let pflFundersValueUrl = null
    if(pflFundingPluginEnabled && funderData) {
      pflFundersValue = '{translate key="plugins.generic.pfl.funders.yes"}';
      pflFundersValueUrl = '#funding-data'
    } else if (pflFundingPluginEnabled) {
      pflFundersValue = '{translate key="plugins.generic.pfl.funders.no"}'
    } else {
      pflFundersValue = '{translate key="common.notApplicableShort"}';
    }

    if(pfl) {
      const data = {$pflData|json_encode};
      data.values.pflFundersValue = pflFundersValue;
      data.values.pflFundersValueUrl = pflFundersValueUrl;

      pfl.data = data;
    }
  })
</script>

</section>
