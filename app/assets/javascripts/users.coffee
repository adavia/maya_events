class App.Registration
  constructor: (el) ->
    @el = $(el)
    @toggleButton(true, "Signing up...")

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
        errors.clean()

        window.location.replace "/"
      error: (jqXHR, textStatus, errorThrown) =>
        errors = new App.Error @el
        errors.remove()
        errors.render("user", jqXHR.responseJSON.errors)
      complete: (jqXHR, textStatus) =>
        @toggleButton(false, "Sign up")

  toggleButton: (status, text) ->
    button = @el.find($('input[name="commit"]'))
    button.prop("disabled", status)
    button.val(text)

$(document).on "page:change", ->
  return unless $(".registrations.new").length > 0
  $("[data-behavior~=sign-up-user]").on "submit", (event) ->
    event.preventDefault()
    registration = new App.Registration @


class App.Authentication
  constructor: (el) ->
    @el = $(el)
    @toggleButton(true, "Signing in...")

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
        errors.clean()
        window.location.replace "/"
      error: (jqXHR, textStatus, errorThrown) ->
        console.log JSON.parse(jqXHR.responseText).error
      complete: (jqXHR, textStatus) =>
        @toggleButton(false, "Sign in")

  toggleButton: (status, text) ->
    button = @el.find($('input[name="commit"]'))
    button.prop("disabled", status)
    button.val(text)
        
$(document).on "page:change", ->
  return unless $(".sessions.new").length > 0
  $("[data-behavior~=sign-in-user]").on "submit", (event) ->
    event.preventDefault()
    auth = new App.Authentication @