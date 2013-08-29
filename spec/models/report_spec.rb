require 'spec_helper'

class BaseReport
  include Reporta::Report

  filter :active, as: :boolean
  filter :start_date
end

describe Reporta::Report do
  it 'can be initialized' do
    expect { BaseReport.new }.to_not raise_error
  end

  context 'with boolean filter' do
    it 'converts boolean "0" to false' do
      report = BaseReport.new active: '0'
      expect(report.active).to be_false
    end

    it 'converts boolean "1" to true' do
      report = BaseReport.new active: '1'
      expect(report.active).to be_true
    end
  end

  it 'allows a filter value to be set and retrieved' do
    report = BaseReport.new start_date: '2013-01-19'
    expect(report.start_date).to eq '2013-01-19'
  end
end
