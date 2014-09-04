# Reporta Modules

__reporta-modules__ is a Rails gem packed with modules and helpers to help you build your reports. 

It is also a fork from the original [__reporta__](github.com/uts/reporta) Rails engine gem. 

## Installation

Add Reporta to your Gemfile

```ruby
gem 'reporta-modules'
```

Generate default view templates in your project  
`$ rails generate reporta:views` 

Turn any plain Ruby class into a Reporta class by including `Reporta::Reportable`

```ruby
class YourReport
  include Reporta::Reportable
end
```

## Basic Example

### View Model

```ruby
class ProjectReport
  include Reporta::Reportable

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
    @report = ProjectsReport.new(params[:reporta_form])
  end
end
```

### View

```erb
<%= filters_for @report %>
<%= table_for @report %>
```



## Reporta Modules

### Reporta::Reportable

`Reporta::Reportable` module added some DSL for your covenience to create your report's [__view model/object__](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/).

#### Filters

Report are normally generated based on some filter or a certain criteria.  
For example: 

```ruby
class ProjectReport
  include Reporta::Reportable

  filter :start_date, as: :date, default: '2013-01-01', required: true 
  filter :finish_date, as: :date, default: '2013-12-31', required: true
  filter :status, collection: Status.all, include_blank: false
  filter :exclude_deleted, as: :boolean, default: false
  
  # required method
  def rows 
    # use filters above to manipulate the results
    projects = Project.where(created_at: start_date..finish_date)
      .where(status: status)
    projects = projects.where(deleted_at: nil) if exclude_deleted
    projects
  end
end
```

**Filter Options**

* `required` - set to `true` to force a field to be set. Defaults to `false`.
* `collection` - setting a collection will force the filter to render as a select input.
* `include_blank` - only has an affect if a collection is set. defaults to `true`.
* `as` - set the type of field to render. Available values are `:boolean`, `:string`, `:check_boxes`, `:radio`, `:date`. Defaults to `:string`.
* `default` - set the default value for the filter.
* `label` - set the label of display

#### Columns

When is comes to displaying the report you will generally want to display a subset of data from the rows, custom calculations or maybe some associated data. Here's a quick example of defining a variety of columns.

```ruby
class ProjectReport
  include Reporta::Reportable

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
* `helper` - format your column

### Required Methods

As a very minimum you need to define the `rows` method which will return the rows that are displayed in the report. 

```ruby
class ProjectReport
  include Reporta::Reportable

  def rows
    Project.all
  end
end
```


#### Default View Templates

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

## License  
see MIT-LICENSE 