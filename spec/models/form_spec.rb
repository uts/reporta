require 'spec_helper'
require 'ostruct'

class FormFilters
  include Reporta::Filter

  filter :active, as: :boolean
  filter :start_date, default: '2013-01-01', required: true
  filter :name, required: true
end

describe Reporta::Form do
  let(:filters) { FormFilters.new.filters }

  it 'is initialized with filters and default values' do
    expect { Reporta::Form.new filters, {} }.to_not raise_error
  end

  it 'stores and retreives values based on the filter name' do
    form = Reporta::Form.new filters
    expect(form.active).to be_false
    form.active = true
    expect(form.active).to be_true
  end

  it 'falls back to the filter default value if set' do
    form = Reporta::Form.new filters
    expect(form.start_date).to eq '2013-01-01'
  end

  it 'adds an error message on validation when a required field is missing' do
    form = Reporta::Form.new filters
    expect(form.valid?).to be_false
    expect(form.errors[:name].to_s).to match /required/
  end

  context 'with boolean filter' do
    it 'converts boolean "0" to false' do
      form = Reporta::Form.new filters, active: '0'
      expect(form.active).to be_false
    end

    it 'converts boolean "1" to true' do
      form = Reporta::Form.new filters, active: '1'
      expect(form.active).to be_true
    end
  end

end
