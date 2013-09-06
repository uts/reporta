window.Reporta ||= {}

class Reporta.Chart

  constructor: (selector, @data, @options={}) ->
    @chart = $(selector)

    $.plot(@chart, @data, @options)
