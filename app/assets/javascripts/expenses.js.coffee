# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.datepicker').datepicker format: 'yyyy-mm-dd'

  $('#expense_category_name').autocomplete
    source: $('#expense_category_name').data('autocomplete-source')

  $("#myTab a").click(e) ->
    e.preventDefault()
    $(this).tab "show"