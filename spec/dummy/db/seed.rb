Account.destroy_all
world = Account.create! name: 'World Corp.'
foo = Account.create! name: 'International Foo'

User.destroy_all
User.create first_name: "garrett", last_name: "heinlen", age: 10, gender: "MALE", active: false, account: world
User.create first_name: "bill", last_name: "gates", age: 29, gender: "FEMALE", active: true, account: foo
User.create first_name: "max", last_name: "bowke", age: 10, gender: "MALE", active: false, account: world
