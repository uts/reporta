class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :gender
      t.boolean :active
      t.integer :account_id

      t.timestamps
    end
  end
end
