class User < ActiveRecord::Base
  belongs_to :account
  GENDER = %w/male female/
end
