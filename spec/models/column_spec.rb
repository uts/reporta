require 'spec_helper'
require 'date'

class DummyReport
  include Reporta::Column

  column :name
  column :full_name, class_names: 'foo bar'
  column :date, title: 'Completed at'
  column :formatted_date

  def formatted_date(project)
    project.created_at.strftime("%b %d, %Y")
  end
end

describe Reporta::Column do

  it 'initializes columns' do
    expect { DummyReport.column :name }.to_not raise_error
  end

  context 'with columns defined' do
    subject(:report) { DummyReport.new }

    it 'iterates over columns' do
      expect(report.columns.length).to eq 4
    end

    it 'defaults to the column name' do
      expect(report.columns[:full_name].title).to eq 'Full name'
    end

    it 'sets a custom title' do
      expect(report.columns[:date].title).to eq 'Completed at'
    end

    it 'defaults class names to an empty string' do
      expect(report.columns[:name].class_names).to eq ''
    end

    it 'sets custom class names' do
      expect(report.columns[:full_name].class_names).to eq 'foo bar'
    end

    it 'returns the value using a local method' do
      project = stub(created_at: Date.new(2013, 01, 15))
      expect(report.columns[:formatted_date].value(project)).to eq ''
    end
  end
end
