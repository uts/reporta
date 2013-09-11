class AccountChart
  include Reporta::Report

  filter :gender, collection: %w(Any Male Female), include_blank: false

  x_axis :months, as: :date, format: "%Y-%m-%d"
  y_axis :accounts, title: 'Total Accounts'

  line_chart :sign_ups
  column_chart :average_age, line_width: 20, align: :left

  def months
    @months ||= (1..12).map { |month| Date.new(Date.today.year, month) }
  end

  def sign_ups(month)
    total = accounts_by_month[month.to_date].to_a.size
    [month.to_time.to_i * 1000, total]
  end

  def average_age(month)
    accounts = accounts_by_month[month.to_date]
    average = accounts.sum(&:age) / accounts.size
    [month.to_time.to_i * 1000, average]
  end

  private

  def accounts_by_month
    @accounts_by_month ||= begin
      users = User.all
      if gender.present? && gender != 'Any'
        users = users.where(gender: gender)
      end
      users.group_by do |account|
        account.created_at.beginning_of_month.to_date
      end
    end
  end

end
