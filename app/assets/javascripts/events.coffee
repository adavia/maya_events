# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class App.Event
  constructor: (el) ->
    @el = $(el)
    @toggleButton(true, "Processing...")

    $.ajax
      url: @el.attr("action")
      type: "POST"
      dataType: "json"
      data: @el.serialize()
      beforeSend: (jqXHR) =>
        token = $('meta[name="csrf-token"]').attr("content")
        jqXHR.setRequestHeader "X-CSRF-Token", token
      success: (data, textStatus, jqXHR) =>
        errors = new App.Error @el
        errors.remove()
        errors.clean() unless @el.hasClass("edit_event")

        console.log data
      error: (jqXHR, textStatus, errorThrown) =>
        errors = new App.Error @el
        errors.remove()
        errors.render("event", jqXHR.responseJSON)
      complete: (jqXHR, textStatus) =>
        if @el.hasClass("new_event")
          @toggleButton(false, "Create Event")
        else
          @toggleButton(false, "Update Event")

  toggleButton: (status, text) ->
    button = @el.find($('input[name="commit"]'))
    button.prop("disabled", status)
    button.val(text)

$(document).on "page:change", ->
  return unless $(".events.new").length > 0 || $(".events.edit").length > 0
  $("[data-behavior~=process-event]").on "submit", (event) ->
    event.preventDefault()
    event = new App.Event @
