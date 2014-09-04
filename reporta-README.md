<!--  
Copyright 2013-2014 University of Technology, Sydney (github.com/uts)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
 -->
# Reporta

Reporta is a Ruby on Rails gem designed to make defining and displaying basic reports as simple as possible.

## Compatibility

* Rails 3.x compatible

## Basic Example

The basic example will be creating a report to list projects that were created during a specified date range.

### Model

```ruby
class ProjectReport
  include Reporta::Report

  filter :start_date, default: '2013-01-01', required: true
  filter :finish_date, default: '2013-12-13', required: true

  column :name
  column :created_at

  def rows
    Project.where(created_at: start_date..finish_date)
  end
end
```

### Controller

```ruby
class ProjectReportsController < ApplicationController
  def show
    @report = ProjectsReport.new(params[:form])
  end
end
```

### View

```erb
<%= filters_for @report %>
<%= table_for @report %>
```

## Installation

Add Reporta to your Gemfile

```ruby
gem 'reporta'
```

Turn any plain Ruby class into a Reporta class by including `Reporta::Report`

```ruby
class YourReport
  include Reporta::Report
end
```

## Usage

Reporta is made up of a few components that you can pull together to display your data in a variety of different ways. The major components are the report controller, class definition, view helpers, stylesheets and javascript.

### Report Definition

At the heart of Reporta is the report definition, this is where you get to define what data will be displayed, where that data comes from and how to filter it down.

#### Rows Method

As a very minimum you need to define the `rows` method which will return the rows that are displayed in the report. In this example we are creating a report that will display all projects in the database.

```ruby
class ProjectReport
  include Reporta::Report

  def rows
    Project.all
  end
end
```

#### Filters

Often you will want the row returned by the report to be filter by a certain criteria. Let's create filter our report by a date range any also by a project status field.

```ruby
class ProjectReport
  include Reporta::Report

  filter :start_date, default: '2013-01-01', required: true
  filter :finish_date, default: '2013-12-31', required: true
  filter :status, collection: Status.all, include_blank: false
  filter :exclude_deleted, as: :boolean, default: false

  def rows
    projects = Project.where(created_at: start_date..finish_date)
      .where(status: status)
    projects = projects.where(deleted_at: nil) if exclude_deleted
    projects
  end
end
```

As you can see above once you have defined a filter you will have access to the filter's value by calling a method using the same name as the filter. So if you define a filter named `:start_date` you can then access the value using the `start_date` accessor method.

**Filter Options**

* `required` - set to `true` to force a field to be set. Defaults to `false`.
* `collection` - setting a collection will force the filter to render as a select input.
* `include_blank` - only has an affect if a collection is set. defaults to `true`.
* `as` - set the type of field to render. Available values are `:boolean`, `:string`, `:check_boxes`, `:radio`. Defaults to `:string`.
* `default` - set the default value for the filter.

#### Columns

When is comes to displaying the report you will generally want to display a subset of data from the rows, custom calculations or maybe some associated data. Here's a quick example of defining a variety of columns.

```ruby
class ProjectReport
  include Reporta::Report

  column :name
  column :formatted_date, title: 'Created at'
  column :manager, data_chain: 'manager.full_name'
  column :cost, class_names: 'sum currency'

  def rows
    Projects.all
  end

  def formatted_date(project)
    project.created_at.strftime("%b %d, %Y")
  end
end
```

**Column Options**

* `title` - set a custom title for the colum. Defaults to the column name
* `data_chain` - provide a chain of methods to call in order to fetch the data.
* `class_names` - these classes will be applied to the column to allow for custom styling or Javascript hooks.

#### Views

In order to render the results of your report there are a variety of different ways to access and display the data. If you have any filters defined you will probably want to display a form for the user to enter parameters into.

The `filters_for` helper generates a basic form based on the filters you have defined.

```erb
<%= filters_for @report %>
```
If we look at how `filters_for` is created you can see the underlying data structures used to render the form.

```erb
<%= form_for @report.form do |f| %>
  <% @report.filters.each do |filter| %>
    <%= f.label filter.name %>
    <%= f.text_field filter.name %>
  <% end %>
  <%= f.submit %>
<% end %>
```
To display the results of the report you can simply use the `table_for` helper method.

```erb
<%= table_for @report %>
```
Or for more detailed control you can build the table yourself.

```erb
<table>
  <thead>
  	<tr>
      <% @report.columns.each do |column| %>
        <th class="#{column.class_names}">
       	  <%= column.title %>
        </th>
      <% end %>
    </tr>
  </thead>
  <tbody>
    <% @report.rows.each do |record| %>
      <tr>
        <% @report.columns.each do |column| %>
          <th class="#{column.class_names}">
            <%= @report.value_for(record, column) %>
          </th>
        <% end %>
      </tr>
    <% end %>
  </tbody>
</table>
```

