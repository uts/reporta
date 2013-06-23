module Reporta
  module ApplicationHelper

    def filters_for(report)
      render partial: "reporta/reports/filters", locals: { report: report }
    end

    def table_for(report)
      render partial: "reporta/reports/table", locals: { report: report }
    end
  end
end
