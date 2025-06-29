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
<script>

window.addEventListener("DOMContentLoaded", () => {
  var pflData = {$pflData|json_encode};
  {literal}

  const localeUrl = pflData.baseUrl + '/locale/' + pflData.locale + '.json';
  fetch(localeUrl)
    .then(function(response) {
      return response.json();
    })
    .then(function(labels) {
      var pfl = document.querySelector('publication-facts-label');
      pfl.data = Object.assign({}, pflData, {labels: labels});
    })
    .catch(function(err) {
      console.warn('PFL: failed to load translations', err);
    });
  {/literal}

  });

</script>

</section>
