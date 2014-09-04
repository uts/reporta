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

    def pie_chart_for(report, x, y, locals={})
      locals.reverse_merge!(
        report: report, 
        x: x,
        y: y, 
        prefix: report.class.to_s.demodulize, 
        rows: report.rows,
        color: '#46BFBD')
      render partial: "reporta/reports/chartjs_pie", locals: locals
    end
 
    def bar_chart_for(report, x, y, locals={})
      locals.reverse_merge!(
        report: report, 
        x: x,
        y: y, 
        prefix: report.class.to_s.demodulize, 
        rows: report.rows,
        color: '#46BFBD')
      render partial: "reporta/reports/chartjs_bar", locals: locals
    end
 
    def chart_pie_from_rows(rows, x, y)
      return {datasets:'[]', colors: '{}'} if rows.blank?
      chart = {colors: {}, datasets: ''}
      data = []
      rows.each do |row|
        color = cycle(*colors)
        value = row.send(y)
        label = row.send(x) || "Unknown"
        data << { label: "#{label.humanize}", value: value, color: color }
        chart[:colors][row.send(x)] = color
      end
      chart[:datasets] = data.to_json
      chart
    end

    def colors
      ['#F38630', '#E0E4CC', '#69D2E7','#F7464A', '#E2EAE9', '#D4CCC5', '#949FB1', '#4D5360']
    end
 
    def labels_from_rows(rows, attr, length=11)
      return [] if rows.empty?
      rows.collect{|r| 
        row = r.send(attr)
        row = row.blank? ? 'Unknown' : row
        truncate(row.to_s, length: length)}
    end

    def decimals_from_rows(rows, x, y, precision=2)
      return [] if rows.blank?
      rows.collect{|r| 
        row = r.send(y)
        row = row.blank? ? 0 : row 
        number_with_precision(row.to_f, precision: precision).to_f }
    end
    
  end
end
