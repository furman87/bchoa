$(document).ready(function() {

  $('.chosen-select').chosen();
  
  $('#residents-list').DataTable({
    "pageLength": 50
  });

  $('.residents').DataTable({
    "pageLength": 50
  });

  $(".dataTables_filter input").focus();

  $("#add-to-mail-group").click(function () {
    alert("Handler for click() called")
  })

  $("#remove-from-mail-group").click(function () {
    alert("Handler for click() called")
  })

});
