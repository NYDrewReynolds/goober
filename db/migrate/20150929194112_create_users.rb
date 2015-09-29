class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :password_digest
      t.boolean :role, null: false, default: false
      t.string :car_make
      t.string :car_model
      t.string :car_capacity

      t.timestamps null: false
    end
  end
end
