class AddTempPasswordToCustomerUser < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_users, :temp_password, :string
    add_column :customer_users, :temp_password_sent_at, :datetime
  end
end
