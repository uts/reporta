class ProjectReport
  include Reporta::Report

  filter :first_name
  filter :age
  filter :gender, collection: %w(Any Male Female), include_blank: false
  filter :active, as: :boolean

  column :first_name, helper: :mailto
  column :last_name
  column :age, class_names: 'highlight'
  column :gender
  column :active, title: 'Enabled'
  column :account, data_chain: 'account.name'
  column :created

  def records
    users = User.where(active: active)

    # Filter by substring match on first_name
    if first_name.present?
      users = users.where("LOWER(users.first_name) LIKE '%#{first_name.downcase}%'")
    end

    # Filter by selecte age
    users = users.where(age: age) if age.present?

    # Filter by gender unless the 'Any' option is selected
    if gender.present? && gender != 'Any'
      users = users.where(gender: gender)
    end

    users
  end

  def created(user)
    user.created_at.strftime("%b %d, %Y")
  end
end
