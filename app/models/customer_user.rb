class CustomerUser < ApplicationRecord
  has_secure_password
  belongs_to :customer

  scope :by_customer, ->(customer_id) { where(customer_id: customer_id).order('id desc') }

  def self.new_customer_user(params)
    customer_user = CustomerUser.new
    customer_user.first_name = params[:first_name]
    customer_user.last_name = params[:last_name]
    customer_user.email = params[:email]
    customer_user.password = params[:password]
    customer_user.active = false
    customer_user.customer_id = params[:customer_id]
    customer_user.save!

    customer_user
  end

  def self.update_customer_user(customer_user, params)
    raise 'Usuário não informado!' if customer_user.blank?
    
    customer_user.first_name = params[:first_name]
    customer_user.last_name = params[:last_name]
    customer_user.email = params[:email]
    customer_user.password = params[:password] if params[:password].present?
    customer_user.save!

    customer_user
  end

  def self.enable_disable(customer_user_id, status)
    raise 'Status não informado!' if status.blank?
    raise 'ID não informado!' if customer_user_id.blank?

    customer_user = find(customer_user_id)
    raise 'Usuário não encontrado!' if customer_user.blank?
    customer_user.active = status
    customer_user.save!
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

  def self.select_customer_users(customer_id)
    customer_users = by_customer(customer_id)
    list = []

    customer_users.each do |cs|
      list.push({value: cs.id, label: "#{cs.first_name} #{cs.last_name}"})
    end

    list
  end
end
