class SendMail < ApplicationMailer
  default from: 'assistente.virtual@mineradados.com.br'

  def forgot_password(name, email, token)
    @name = name
    @link = "#{Figaro.env.minera_front}/nova_senha?token=#{token}"
    mail(to: email, subject: 'Recuperação de senha')
  end

  def new_customer(name, email)
    @name = name
    @email = email
    mail(to: email, subject: 'Bem-vindo!')
  end

  def new_customer_user(name, email, password)
    @name = name
    @email = email
    @password = password
    mail(to: email, subject: 'Segue seus dados de acesso')
  end
end