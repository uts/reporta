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
