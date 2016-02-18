# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class App.Attendance
  constructor: (el) ->
    @el = $(el)

$(document).ready ->
  return unless $(".events.show").length > 0
  $(document).on "ajax:success", "[data-behavior~=btn-state-request]", (event, data, status, xhr) ->
    $("#toggle-request").html(data)

  $(document).on "ajax:error", "[data-behavior~=btn-state-request]", (event, xhr, status, error) ->
    console.log "Something went wrong"