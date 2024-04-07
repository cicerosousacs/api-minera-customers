class SendMail < ApplicationMailer
  default from: 'assistente.virtual@mineradados.com.br'

  def forgot_password(nome, email, token)
    # byebug
    @nome = nome
    @url = "#{Figaro.env.minera_front}/nova_senha?token=#{token}"
    mail(to: email, subject: 'Recuperação de senha')
  end
end