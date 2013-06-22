require 'spec_helper'

class DummyReport
  include Reporta::Column
end

describe Reporta::Column do

  it 'initializes columns' do
    expect { DummyReport.column :name }.to_not raise_error
  end

  context 'with columns defined' do
    before :each do
      DummyReport.column :name
      @report = DummyReport.new
    end

    it 'iterates over columns' do
      expect(@report.columns.length).to eq 1
    end

    it 'defaults to the column name' do
      DummyReport.column :full_name
      report = DummyReport.new
      expect(report.columns[:full_name].title).to eq 'Full name'
    end

    it 'sets a custom title' do
      DummyReport.column :name, title: 'Full name'
      report = DummyReport.new
      expect(report.columns[:name].title).to eq 'Full name'
    end

    it 'defaults class names to an empty string' do
      DummyReport.column :name
      report = DummyReport.new
      expect(report.columns[:name].class_names).to eq ''
    end

    it 'sets custom class names' do
      DummyReport.column :name, class_names: 'foo bar'
      report = DummyReport.new
      expect(report.columns[:name].class_names).to eq 'foo bar'
    end

  end
end
