class ProjectReport
  include Reporta::Report

  filter :first_name, default: "Garrett"
  filter :age, required: true
  filter :gender, collection: %w/MALE FEMALE/, include_blank: false
  filter :active, as: :boolean

  column :first_name
  column :last_name
  column :age
  column :gender
  column :active, title: 'Enabled'
  column :account, data_chain: 'account.name'
  column :created

  def records
    User.where(gender: gender)
      .where(age: age)
      .where(active: active)
      .where(first_name: first_name.downcase)
  end

  def created(user)
    user.created_at.strftime("%b %d, %Y")
  end
end
