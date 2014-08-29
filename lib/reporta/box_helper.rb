module Reporta
  module BoxHelper
    include ActionView::Helpers::NumberHelper
    def readable_number(num)
      num = num || 0
      opts = {units: { thousand: 'K', million: 'M', billion: 'B'}}
      number_to_human(num, opts)
    end

    def box_for(report, locals={})
      locals.reverse_merge!(report: report)
      render partial: 'reporta/reports/box', locals: locals
    end
  end
end


