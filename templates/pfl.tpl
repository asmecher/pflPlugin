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

    if(pfl) {
      pfl.data = {$pflData|json_encode};
    }
  })
</script>

</section>
