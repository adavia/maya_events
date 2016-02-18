# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class App.Attendance
  constructor: (el) ->
    @el = $(el)

$(document).on "page:change", ->
  return unless $(".events.show").length > 0

  # Toggle btn request
  $(document).on "ajax:success", "[data-behavior~=btn-state-request]", (event, data, status, xhr) ->
    $("#toggle-request").html(data)

  $(document).on "ajax:error", "[data-behavior~=btn-state-request]", (event, xhr, status, error) ->
    console.log "Something went wrong"

  # Accept request
  $(document).on "ajax:success", "[data-behavior~=btn-accept-request]", (event, data, status, xhr) ->
    pending = $("#pending-request")
    accepted = $("#accepted-request")

    $(@).parent().parent("li").remove()
    accepted.find("li:first-child:contains('No attendees for this event')").remove()
    accepted.append(data)
    if $("#pending-request li").length == 0
      pending.html("<li>No pending requests for this event</li>")

  $(document).on "ajax:error", "[data-behavior~=btn-accept-request]", (event, xhr, status, error) ->
    console.log "Something went wrong"

  # Reject request
  $(document).on "ajax:success", "[data-behavior~=btn-reject-request]", (event, data, status, xhr) ->
    $(@).parent().parent("li").remove()
    if $("#pending-request li").length == 0
      $("#pending-request").html("<li>No pending requests for this event</li>")

  $(document).on "ajax:error", "[data-behavior~=btn-reject-request]", (event, xhr, status, error) ->
    console.log "Something went wrong"