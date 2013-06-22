class ProjectReport
  include Reporta::Report

  filter :first_name, default: "Garrett"
  filter :last_name
  filter :age
  filter :gender, collection: %w/MALE FEMALE/, include_blank: false
  filter :active, as: :boolean

  column :first_name
  column :last_name
  column :age
  column :gender
  column :active

  def records
    User.all
  end

end
