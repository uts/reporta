require 'spec_helper'

class DummyReport
  include Reporta::Report
end

describe Reporta::Report do
  it 'can be initialized' do
    expect { DummyReport.new }.to_not raise_error
  end
end
