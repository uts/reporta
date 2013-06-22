require 'spec_helper'

class DummyReport
  include Reporta::Filter
end

describe Reporta::Filter do
  it 'initializes filters' do
    expect { DummyReport.filter :start_date }.to_not raise_error
  end

  context 'with columns defined' do
    before :each do
      DummyReport.filter :start_date
      @report = DummyReport.new
    end

    it 'iterates over filters' do
      expect(@report.filters.length).to eq 1
    end

    it 'defaults to the filter name' do
      DummyReport.filter(:start_date, {default: '2013-01-01'})
      report = DummyReport.new
      expect(report.filters[:start_date].default).to eq '2013-01-01'
    end

    it 'sets a custom title' do
      DummyReport.filter :start_date, required: true
      report = DummyReport.new
      expect(report.filters[:start_date].required).to eq true
    end

    it 'sets custom class names' do
      DummyReport.filter :start_date, as: :boolean
      report = DummyReport.new
      expect(report.filters[:start_date].as).to eq :boolean
    end

    it "collection - setting a collection will force the filter to render as a select input."
    it "include_blank - only has an affect if a collection is set. defaults to true."
  end
end
