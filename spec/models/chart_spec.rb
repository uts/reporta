require 'spec_helper'

class ChartReport
  include Reporta::Chart

  x_axis :months
  y_axis :accounts, title: 'Total Accounts'

  line_chart :sign_ups
  column_chart :average_age

  def months
    @months ||= (1..12).map { |month| Date.new(Date.today.year, month) }
  end

  def sign_ups(month)
    accounts_by_month[month].size
  end

  def average_age(month)
    accounts = accounts_by_month[month]
    accounts.sum(&:age) / accounts.size
  end

  private

  def accounts_by_month
    @accounts_by_month ||= begin
      Account.all.group_by do |account|
        account.created_at.beginning_of_month
      end
    end
  end

end

describe Reporta::Chart do
  it 'can be initialized' do
    expect { ChartReport.new }.not_to raise_error
  end

  it 'has an x and y axis' do
    report = ChartReport.new
    expect(report.x_axis.title).to eq 'Months'
    expect(report.y_axis.title).to eq 'Total Accounts'
  end
end
