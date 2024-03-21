class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :description
      t.references :type_subscription, null: false, foreign_key: true
      t.integer :quantity_users
      t.integer :quantity_companies
      t.float :price

      t.timestamps
    end
  end
end
