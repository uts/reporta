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

    it 'sets a custom title'

  end
end
