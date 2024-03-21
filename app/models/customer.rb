class Customer < ApplicationRecord
  belongs_to :status
  belongs_to :subscription
  
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
end
