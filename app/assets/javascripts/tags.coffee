# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class App.Tag
  constructor: (el) ->
    @el = $(el)

  remove: ->
    @el.parent().fadeOut()

$(document).on "page:change", ->
  return unless $(".events.show").length > 0
  $(".tag .remove").on "ajax:success", ->
    tag = new App.Tag @
    tag.remove()

  $(".tag .remove").on "ajax:error", ->
    alert "You are not allowed to delete this tag"