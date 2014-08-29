module Reporta
  module ChartjsHelper
    include ActionView::Helpers::NumberHelper
    
    def line_chart_for(report, x, y, locals={})
      locals.reverse_merge!(
        report: report, 
        x: x,
        y: y, 
        prefix: report.class.to_s.demodulize, 
        rows: report.rows,
        color: '#46BFBD')
      render partial: "reporta/reports/chartjs_line", locals: locals
    end
 
    def labels_from_rows(rows, attr, length=11)
      return [] if rows.empty?
      rows.
        select{|r| r.send(attr).present?}.
        collect{|r| truncate(r.send(attr).to_s, length: length)}
    end

    def decimals_from_rows(rows, x, y, precision=0)
      return [] if rows.blank?
      rows.
        select{|r| r.send(x).present?}.
        collect{|r| number_with_precision(r.send(y),precision: precision).to_i}
    end
    
  end
end
