class AuthenticateCustomer
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    customer
  end

  private

  attr_accessor :email, :password

  def customer
    raise 'Email não informado!' if email.blank?
    raise 'Senha não informada!' if password.blank?
    customer = Customer.find_by(email: email) || CustomerUser.find_by(email: email)
  end
end