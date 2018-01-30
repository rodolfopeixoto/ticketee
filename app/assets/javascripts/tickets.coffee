$ ->
  $("#add_file").on "ajax:success", (event, data) ->
    console.log("Data: ",data)
    $("#attachments").append data
    $(this).data "params", { index: $("#attachments div.file").length }