class Customer < ApplicationRecord
  belongs_to :status
  belongs_to :subscription
  has_many :customer_users
  
  has_secure_password

  def self.new_customer(params)
    customer = Customer.new
    customer.first_name = params[:first_name]
    customer.last_name = params[:last_name]
    customer.email = params[:email]
    customer.password = params[:password]
    customer.status_id = params[:status_id]
    customer.subscription_id = params[:subscription_id]
    customer.save!

    customer
  end

  def self.change_password(old_password, new_password, customer)
    raise 'Senha atual não informada!' if old_password.blank?
    raise 'Nova senha não informada!' if new_password.blank?
    raise 'Usuário não informado!' if customer.blank?

    customer = find_by(email: customer[:email])

    raise 'Usuário não encontrado!' if customer.blank?
    raise 'Senha atual incorreta!' unless customer.authenticate(old_password)

    customer.password = new_password
    customer.save!

    customer
  end

  def self.change_status(status, customer)
    raise 'Status não informado!' if status.blank?
    raise 'Usuário não informado!' if customer.blank?

    customer = find_by(email: customer[:email])
    raise 'Usuário não encontrado!' if customer.blank?

    customer.status_id = status
    customer.save!

    customer
  end

  def self.change_subscription(subscription, customer)
    raise 'Assinatura não informada!' if subscription.blank?
    raise 'Usuário não informado!' if customer.blank?

    customer = find_by(email: customer[:email])
    raise 'Usuário não encontrado!' if customer.blank?

    customer.subscription_id = subscription
    customer.save!

    customer
  end

  def self.update_customer(params, customer)
    raise 'Usuário não informado!' if customer.blank?

    customer = find_by(email: customer[:email])
    raise 'Usuário não encontrado!' if customer.blank?

    customer.first_name = params[:first_name] if params[:first_name].present?
    customer.last_name = params[:last_name] if params[:last_name].present?
    customer.phone = params[:email] if params[:email].present?
    customer.cellphone = params[:cellphone] if params[:cellphone].present?
    customer.cep = params[:cep] if params[:cep].present?
    customer.street = params[:street] if params[:street].present?
    customer.number = params[:number] if params[:number].present?
    customer.complement = params[:complement] if params[:complement].present?
    customer.reference = params[:reference] if params[:reference].present?
    customer.district = params[:district] if params[:district].present?
    customer.city = params[:city] if params[:city].present?
    customer.state = params[:state] if params[:state].present?
    customer.subscription_id = params[:subscription_id] if params[:subscription_id].present?
    customer.save!
    
    customer
  end
end
