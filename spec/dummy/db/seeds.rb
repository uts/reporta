Account.delete_all
User.delete_all

accounts = []
10.times do |n|
  accounts << Account.create!(name: Faker::Name.name)
end

100.times do |n|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: rand(18..95),
    gender: ['Male', 'Female'].sample,
    active: [true, false].sample,
    account: accounts.sample
  )
end
