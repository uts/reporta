class ProjectReport
  include Reporta::Report
  include Reporta::Filter
  include Reporta::Column

  filter :first_name, default: "Garrett"
  filter :last_name
  filter :age, include_blank: false
  filter :gender, collection: %w/MALE FEMALE/
  filter :active, as: :boolean

  column :first_name
  column :last_name
  column :age
  column :gender
  column :active
end
