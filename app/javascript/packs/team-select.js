import $ from 'jquery'

$(function() {
  const teamSelect = $('.team-select');
  const originalValue = teamSelect.val();

  teamSelect.on('change', function(e) {
    const redirectTo = e.target.value;
    if (redirectTo) {
      window.location = redirectTo;

      // Hack to get team to show up correctly when navigating back.
      // eg: Using the browser's back button
      teamSelect.val(originalValue);
    }
  });
});
