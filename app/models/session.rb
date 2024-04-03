class Session < ApplicationRecord
  def self.new_session(customer)
    exp = Time.current.to_i + 1.hour.to_i
    payload = { 
      user_id: customer[:id],
      user_name: customer[:first_name] + ' ' + customer[:last_name],
      user_type: customer.class.name, 
      user_subscription: customer.class.name == 'Customer' ? customer.subscription.id : customer.customer.subscription.id,
      exp: exp 
    }

    token = generate_token(payload)

    Session.create!(key: token, email: customer[:email])

    token
  end

  def self.validate_session(token)
    begin
      session = find_by(key: token)
      token = decode_token(token)
      token[0]['exp'] > Time.current.to_i if session.present?
    rescue JWT::ExpiredSignature
      false
    end
  end

  def self.destroy_session(token)
    validate_session(token)

    session = find_by(key: token)
    session.destroy if session.present?
    Session.find_by(key: token).nil?
  end

  private

  def self.generate_token(payload)
    JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
  end

  def self.decode_token(token)
    JWT.decode token, Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' }
  end
end
