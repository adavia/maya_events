# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $(".tag .remove").on "ajax:success", ->
    $(this).parent().fadeOut()
  $(".tag .remove").on "ajax:error", ->
    alert "You are not allowed to delete this tag"