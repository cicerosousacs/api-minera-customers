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
    # customer_user = find(params[:id])
    # byebug
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
end
