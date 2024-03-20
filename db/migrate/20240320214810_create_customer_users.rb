class CreateCustomerUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.references :customer, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
