class CreateCompaniesByCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :companies_by_customers do |t|
      t.integer :customer_id
      t.integer :quantity_company
      t.integer :quantity_company_references
      t.integer :quantity_company_remaining

      t.timestamps
    end
  end
end
