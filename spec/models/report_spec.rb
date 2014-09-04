require 'spec_helper'

class BaseReport
  include Reporta::Reportable

  filter :active, as: :boolean
  filter :start_date
end

describe Reporta::Reportable do
  it 'can be initialized' do
    expect { BaseReport.new }.to_not raise_error
  end

  it 'initializes and validates a new Form' do
    args = { name: 'Joe' }
    filters = double()
    form = double()

    expect(form).to receive(:valid?)
    expect(Reporta::Form).to receive(:new).with(filters, args).and_return form
    BaseReport.any_instance.stub(:filters).and_return(filters)

    BaseReport.new args
  end

  it 'allows a filter value to be set and retrieved' do
    report = BaseReport.new start_date: '2013-01-19'
    expect(report.start_date).to eq '2013-01-19'
  end
end
