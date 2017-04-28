$(document).ready(function() {

  $('.chosen-select').chosen();
  $('#residents-list').DataTable({
    "pageLength": 50
  });

});
