import $ from 'jquery';

const BLOCKER_WRAPPER_SELECTOR = '.standup-form-blocker';
const BLOCKER_INPUT_SELECTOR = `${BLOCKER_WRAPPER_SELECTOR} input`;
const BLOCKER_REMOVE_SELECTOR = `${BLOCKER_WRAPPER_SELECTOR} .remove`;
const ADD_ANOTHER_SELECTOR = '.standup-form-add-blocker';

$(function() {
  $(BLOCKER_INPUT_SELECTOR).on('keydown', function(e) {
    if (e.keyCode == 13) {
      e.preventDefault();
      addAnotherBlocker();
    }
  });

  $(ADD_ANOTHER_SELECTOR).on('click', function(e) {
    e.preventDefault();
    addAnotherBlocker();
  });

  $(BLOCKER_REMOVE_SELECTOR).on('click', function(e) {
    e.preventDefault();
    if ($(BLOCKER_WRAPPER_SELECTOR).length > 1) {
      $(e.target).parents(BLOCKER_WRAPPER_SELECTOR).remove();
    }
  });
});

const addAnotherBlocker = function() {
  const blockers = $(BLOCKER_WRAPPER_SELECTOR);
  const newBlocker = blockers.first().clone(true);
  const newBlockerInput = newBlocker.find('input');

  incrementAttr(newBlockerInput, 'id', blockers.length);
  incrementAttr(newBlockerInput, 'name', blockers.length);
  newBlockerInput.val('');

  newBlocker.insertBefore(ADD_ANOTHER_SELECTOR);
  newBlockerInput.focus();
};

const incrementAttr = function(element, property, newValue) {
  element.attr(
    property,
    element.attr(property).replace('0', newValue)
  );
};
