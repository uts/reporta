require 'spec_helper'

class FilteredReport
  include Reporta::Filter

  filter :start_date, default: '2013-01-01'
  filter :finish_date
  filter :active, as: :boolean
  filter :employee_type, required: true
  filter :age, include_blank: false
  filter :be_blank_true
  filter :valid, collection: %w/true false/
end

describe Reporta::Filter do
  context 'with columns defined' do
    subject(:report) { FilteredReport.new }

    it 'defaults to correct date' do
      expect(report.filters[:start_date].default).to eq '2013-01-01'
    end

    it 'accepts boolean column types' do
      expect(report.filters[:active].as).to eq :boolean
    end

    it 'requires columns to be set' do
      expect(report.filters[:employee_type].required).to eq true
    end

    it 'allows include_blank to bet set' do
      expect(report.filters[:age].include_blank).to eq false
    end

    it 'defaults include_blank to true' do
      expect(report.filters[:be_blank_true].include_blank).to eq true
    end

    it 'allows collections to be set' do
      expect(report.filters[:valid].collection).to eq %w/true false/
    end
  end
end
