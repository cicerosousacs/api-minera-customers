class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :gender
      t.string :cpf
      t.string :cnpj
      t.string :phone
      t.string :cellphone
      t.date :birth_date
      t.string :cep
      t.string :street
      t.integer :number
      t.string :complement
      t.string :reference
      t.string :district
      t.string :city
      t.string :state
      t.boolean :authenticated_email
      t.references :status, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.integer :quantity_profiles

      t.timestamps
    end
  end
end
