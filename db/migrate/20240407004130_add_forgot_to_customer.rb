class AddForgotToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :forgot_password_token, :string
    add_column :customers, :forgot_password_sent_at, :datetime
  end
end
