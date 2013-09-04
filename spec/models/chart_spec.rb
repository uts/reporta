require 'spec_helper'

class ChartReport
  include Reporta::Chart

  x_axis :months
  y_axis :accounts, title: 'Total Accounts'

  line_chart :sign_ups
  column_chart :average_age

  def months
    @months ||= (1..12).map { |month| Date.new(2013, month) }
  end

  def sign_ups(month)
    accounts_by_month[month].size
  end

  private

  def accounts_by_month
    {
      Date.new(2013, 01) => ['Joe', 'Mary', 'Steve'],
      Date.new(2013, 02) => ['Dave', 'Sarah'],
      Date.new(2013, 03) => ['Jerry'],
    }
  end

end

describe Reporta::Chart do
  it 'has an x and y axis with sensible titles' do
    report = ChartReport.new
    expect(report.x_axis.title).to eq 'Months'
    expect(report.y_axis.title).to eq 'Total Accounts'
  end

  it 'has line charts' do
    report = ChartReport.new
    expect(report.line_charts[:sign_ups].title).to eq 'Sign ups'
  end

  it 'has columns charts' do
    report = ChartReport.new
    expect(report.column_charts[:average_age].title).to eq 'Average age'
  end

  it 'returns a series of values for a line chart' do
    report = ChartReport.new
    series = [3, 2, 1]
    expect(report.series_for(:sign_ups)).to eq series
  end
end
