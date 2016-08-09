$(document).ready(function() {

    $("#add-article-attachment").
        data("association-insertion-node", "#article-attachments").
        data("association-insertion-method", "before");

    $('.datepicker').datepicker({
        format: "yyyy-mm-dd",
        autoclose: true,
        todayHighlight: true
    });

});
