require 'spec_helper'

class DummyReport
  include Reporta::Filter

  filter :start_date, default: '2013-01-01'
  filter :finish_date, default: '2013-12-13'
end

describe Reporta::Filter do
  it 'can be initialized' do
    expect { DummyReport.new }.to_not raise_error
  end

  context 'with filter containing all available options' do
    before(:each) do
      DummyReport.filter(:start_date, default: '2013-01-01')
      DummyReport.filter(:finish_date, default: (Date.today + 5.days))
      @report = DummyReport.new
    end

    it 'returns the default value when none is supplied' do
      expect(@report.start_date).to eq '2013-01-01'
    end

    it 'allows the defaults to be overridden' do
      expect(@report.start_date).to eq '2013-01-01'
    end

    it 'provides a way to iterate over each filter and retrieve the name and options' do
      expect(@report.filters.size).to eq 2
      filter = @report.filters.first
      expect(filter.name).to eq :start_date
      expect(filter.options).to eq({ :default => '2013-01-01' })
    end
  end

  context "Validations" do
    it 'raises an error if name is blank' do
      DummyReport.filter(:start_date, required: true)
      abc = DummyReport.new
      expect(abc.errors[:start_date]).to eq "Can't be blank"
    end
  end

  it "required - set to true to force a field to be set. Defaults to false."
  it "default - set the default value for the filter."
  
  it "collection - setting a collection will force the filter to render as a select input."
  it "include_blank - only has an affect if a collection is set. defaults to true."
  it "as - set the type of field to render. Available values are :boolean, :string, :check_boxes, :radio. Defaults to :string."

end
