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
