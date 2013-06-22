require 'spec_helper'

class DummyReport
  include Reporta::Filter

  filter :start_date, default: '2013-01-01'
  filter :finish_date
  filter :active, as: :boolean
  filter :employee_type, required: true
end

describe Reporta::Filter do
  context 'with columns defined' do
    before(:each) { @report = DummyReport.new }

    it 'iterates over filters' do
      expect(@report.filters.length).to eq 4
    end

    it 'defaults to correct date' do
      expect(@report.filters[:start_date].default).to eq '2013-01-01'
    end

    it 'accepts boolean column types' do
      expect(@report.filters[:active].as).to eq :boolean
    end

    it 'requires columns to be set' do
      expect(@report.filters[:employee_type].required).to eq true
    end

    it "collection - setting a collection will force the filter to render as a select input."
    it "include_blank - only has an affect if a collection is set. defaults to true."
  end
end
