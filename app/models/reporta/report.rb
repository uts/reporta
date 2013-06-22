module Reporta
  module Report
    extend ActiveSupport::Concern
    include Filter
    include Column
  end
end
