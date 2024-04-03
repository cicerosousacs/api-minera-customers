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

  def self.leads_remaining_by_customer(params)
    customer_id = params[:id]
    type = params[:type]
    companies_by_customer = nil

    raise 'ID não informado!' if customer_id.blank?
    raise 'Tipo não informado!' if type.blank?

    if type == 'Customer'
      companies_by_customer = where(customer_id: customer_id).first

      raise 'Cliente não encontrado!' if companies_by_customer.blank?
    else
      customer_user = CustomerUser.find(customer_id)

      raise 'Cliente não encontrado!' if customer_user.blank?

      companies_by_customer = where(customer_id: customer_user.customer.id).first
    end
    companies_by_customer.quantity_company_remaining
  end

  def self.update_companies_by_customer(customer_id, quantity, user_type)
    companies_by_customer = nil
    
    raise 'Quantidade de Leads não informada!' if quantity.blank?
    raise 'Tipo de Usuário não informado!' if user_type.blank?
    raise 'ID não informado!' if customer_id.blank?


    if user_type == 'Customer'
      companies_by_customer = where(customer_id: customer_id).first
    else
      customer_user = CustomerUser.find(customer_id)
      companies_by_customer = where(customer_id: customer_user.customer.id).first
    end

    raise 'Cliente não encontrado!' if companies_by_customer.blank?
    raise 'Limite de Leads atingido!' if companies_by_customer.quantity_company_remaining == 0

    companies_by_customer.quantity_company += quantity.to_i
    companies_by_customer.quantity_company_remaining = companies_by_customer.quantity_company_references - companies_by_customer.quantity_company
    companies_by_customer.save!
  end
end
