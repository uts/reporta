window.Reporta ||= {}

class Reporta.DynamicTable

  bootstrapOptions =
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    oLanguage:
      sLengthMenu: "_MENU_ records per page"

  constructor: (selector, @options={}) ->
    @table = $(selector)

    if @options.bootstrap
      delete @options.bootstrap
      @options = $.extend @options, bootstrapOptions

    @table.dataTable @options
