(function() {
	const pflModals = {};

	const modalIds = [
		'pfl-modal-publication-facts-label',
		'pfl-modal-for-other-journals',
		'pfl-modal-publisher',
		'pfl-modal-for-other-articles',
		'pfl-modal-indexes',
		'pfl-modal-editorial-team',
		'pfl-modal-articles-accepted',
		'pfl-modal-peer-reviewers',
		'pfl-modal-competing-interests',
		'pfl-modal-data-availability',
		'pfl-modal-funders'
	];
	let modalsStack = [];
	modalIds.forEach(function(modalId) {
		pflModals[modalId] = new A11yDialog(document.getElementById(modalId));
		pflModals[modalId].on('show', function(element, event) {
			const openingDialogId = element.id;

			if (!modalsStack.includes(openingDialogId)) {
				modalsStack.push(openingDialogId);
			}
			if (modalsStack.length === 2) {
				pflModals[modalsStack[0]].hide();
			}

			const scrollableElement = document.querySelector(
				'#' + openingDialogId + ' .pfl-dialog-content'
			);
			bodyScrollLock.disableBodyScroll(scrollableElement);

			return;
		});
		pflModals[modalId].on('hide', function(element, event) {
			const closingDialogId = element.id;

			const scrollableElement = document.querySelector(
				'#' + closingDialogId + ' .pfl-dialog-content'
			);

			bodyScrollLock.enableBodyScroll(scrollableElement);

			if (modalsStack[modalsStack.length - 1] === closingDialogId) {
				modalsStack.pop();
				if (modalsStack.length) {
					pflModals[modalsStack[0]].show();
				}
			}
		});
	});
})();
