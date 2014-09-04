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
require 'date'

class ColumReport
  include Reporta::Column

  column :name
  column :full_name
  column :date, title: 'Completed at'
  column :formatted_date
  column :customer_name, data_chain: 'customer.name'
  column :email_customer, helper: :customer_email_link

  def formatted_date(project)
    project.created_at.strftime('%b %d, %Y')
  end
end

describe Reporta::Column do

  it 'initializes columns' do
    expect { ColumReport.column :name }.to_not raise_error
  end

  context 'with columns defined' do
    subject(:report) { ColumReport.new }

    it 'defaults to the column name' do
      expect(report.columns[:full_name].title).to eq 'Full name'
    end

    it 'sets a custom title' do
      expect(report.columns[:date].title).to eq 'Completed at'
    end
    
    it 'returns the value using a local method' do
      project = double created_at: Date.new(2013, 01, 15)
      expect(
        report.value_for(project, :formatted_date)
      ).to eq 'Jan 15, 2013'
    end

    it 'uses a chain of methods of fetch the value' do
      customer = double name: 'World Co.'
      project = double customer: customer
      expect(report.value_for(project, :customer_name))
        .to eq 'World Co.'
    end

    it 'sets a custom helper' do
      expect(report.columns[:email_customer].helper).to eq :customer_email_link
    end

  end
end
