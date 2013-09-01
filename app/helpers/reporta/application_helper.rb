module Reporta
  module ApplicationHelper

    def filters_for(report)
      render partial: "reporta/reports/filters", locals: { report: report }
    end

    def table_for(report, locals={})
      locals.reverse_merge!(report: report, class_name: '')
      render partial: "reporta/reports/table", locals: locals
    end
  end
end
