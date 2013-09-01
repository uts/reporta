require 'spec_helper'

class ChartReport
  include Reporta::Chart

  x_axis :months
  y_axis :accounts

  line :sign_ups
  column :average_age

  def months
    @months ||= (1..12).map { |month| Date.new(Date.today.year, month) }
  end

  def sign_ups
    Account.all.group_by do |account|
      account.created_at.beginning_of_month
    end
  end

end

describe Reporta::Chart do
  it 'can be initialized' do
    expect { ChartReport.new }.not_to raise_error
  end
end
