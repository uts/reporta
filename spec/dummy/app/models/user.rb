class User < ActiveRecord::Base
  belongs_to :account
  GENDER = %w/male female/

  def to_s
    first_name
  end
end
