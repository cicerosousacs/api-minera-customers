class CustomerUser < ApplicationRecord
  belongs_to :customer

  has_secure_password

  def self.new_customer_user(params)
    customer_user = CustomerUser.new
    customer_user.first_name = params[:first_name]
    customer_user.last_name = params[:last_name]
    customer_user.email = params[:email]
    customer_user.password = params[:password]
    customer_user.active = params[:active]
    customer_user.customer_id = params[:customer_id]
    customer_user.save!

    customer_user
  end

  def self.change_password(old_password, new_password, customer_user)
    raise 'Senha atual não informada!' if old_password.blank?
    raise 'Nova senha não informada!' if new_password.blank?
    raise 'Usuário não informado!' if customer_user.blank?

    customer_user = find_by(email: customer_user[:email])

    raise 'Usuário não encontrado!' if customer_user.blank?
    raise 'Senha atual incorreta!' unless customer_user.authenticate(old_password)

    customer_user.password = new_password
    customer_user.save!

    customer_user
  end

  def self.change_status(status, customer_user)
    raise 'Status não informado!' if status.blank?
    raise 'Usuário não informado!' if customer_user.blank?

    customer_user = find_by(email: customer_user[:email])
    raise 'Usuário não encontrado!' if customer_user.blank?

    customer_user.active = status
    customer_user.save!

    customer_user
  end
end
