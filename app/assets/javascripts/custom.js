$(document).ready(function() {

  $('.chosen-select').chosen();
  
  $('#residents-list').DataTable({
    "pageLength": 50
  });

  $(".dataTables_filter input").focus();

});
