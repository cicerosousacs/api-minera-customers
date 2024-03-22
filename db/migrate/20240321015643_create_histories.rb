class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.string :type_history
      t.datetime :date_history
      t.string :name_list
      t.string :observation
      t.jsonb :filters
      t.integer :customer_user_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
