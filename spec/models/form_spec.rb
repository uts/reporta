require 'spec_helper'
require 'ostruct'

class FormFilters
  include Reporta::Filter

  filter :active, as: :boolean
end

describe Reporta::Form do
  let(:filters) { FormFilters.new.filters }

  it 'is initialized with filters and default values' do
    expect { Reporta::Form.new filters, {} }.to_not raise_error
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
