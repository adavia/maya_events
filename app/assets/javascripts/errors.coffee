class App.Error
  constructor: (el) ->
    @el = el
  
  render: (model, errors) ->
    $.each errors, (field, messages) =>
      input = @el.find("input, select, textarea").filter ->
        name = $(@).attr("name")
        if name
          regex = model + '\\[' + field + '(?:\\(\\w*\\))?\\](?:\\[\\w*\\]){0,2}?'
          name.match(new RegExp(regex))

      msg = '<span class="help-block">' + @display(field, messages) + '</span>'

      if input.parent().hasClass("form-inline")
        input.parent().parent().addClass("has-error")
        input.parent().append(msg)
      else
        input.parent().addClass("has-error")
        input.after(msg)

  display: (field, messages) ->
    $.map(messages, (m) -> m.charAt(0).toUpperCase() + 
      m.slice(1)).join('<br />')

  remove: ->
    @el.find(".form-group").removeClass("has-error")
    @el.find("span.help-block").remove()

  clean: ->
    @el[0].reset()
