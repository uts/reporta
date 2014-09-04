# Copyright 2013-2014 University of Technology, Sydney (github.com/uts)

# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
    expect(form.active).to be false
    form.active = true
    expect(form.active).to be true
  end

  it 'falls back to the filter default value if set' do
    form = Reporta::Form.new filters
    expect(form.start_date).to eq '2013-01-01'
  end

  it 'adds an error message on validation when a required field is missing' do
    form = Reporta::Form.new filters
    expect(form.valid?).to be false
    expect(form.errors[:name].to_s).to match /required/
  end

  describe 'filters_applied?' do
    it 'is false when no values are initialized' do
      form = Reporta::Form.new filters
      expect(form.filter_applied?).to be false
    end

    it 'is true when one or more values are initialized' do
      form = Reporta::Form.new filters, active: true
      expect(form.filter_applied?).to be true
    end
  end

  context 'with boolean filter' do
    it 'converts boolean "0" to false' do
      form = Reporta::Form.new filters, active: '0'
      expect(form.active).to be false
    end

    it 'converts boolean "1" to true' do
      form = Reporta::Form.new filters, active: '1'
      expect(form.active).to be true
    end
  end

end
