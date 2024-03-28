class CompaniesByCustomer < ApplicationRecord
  scope :by_customer, ->(customer_id) { where(customer_id: customer_id).first.quantity_company_remaining }

  def self.save_companies_by_customer(customer_id)
    customer = Customer.find(customer_id)

    companies_by_customer = CompaniesByCustomer.new
    companies_by_customer.customer_id = customer.id
    companies_by_customer.quantity_company = 0
    companies_by_customer.quantity_company_remaining = companies_by_customer.quantity_company_references = customer.subscription.quantity_companies
    companies_by_customer.save!

    companies_by_customer
  end

  def self.update_companies_by_customer(customer_id, quantity)
    companies_by_customer = where(customer_id: customer_id).first

    raise 'Cliente não encontrado!' if companies_by_customer.blank?
    raise 'Quantidade de Leads não informada!' if quantity.blank?
    raise 'Limite de Leads atingido!' if companies_by_customer.quantity_company_remaining == 0

    companies_by_customer.quantity_company += quantity.to_i
    companies_by_customer.quantity_company_remaining = companies_by_customer.quantity_company_references - companies_by_customer.quantity_company
    companies_by_customer.save!
  end
end
