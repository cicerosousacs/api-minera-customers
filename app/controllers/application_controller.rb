class ApplicationController < ActionController::API
  before_action :set_token

  def authenticated?
    validate_session
  rescue StandardError
    render json: { status: 401, message: 'Não autorizado' }, status: :unauthorized, content_type: 'application/json'
  end

  def validate_session
    raise ActionController::InvalidAuthenticityToken, 'Token não informado' if @token.blank?

    valid = Session.validate_session(@token)
    raise JWT::DecodeError, 'Token inválido' unless valid
  end

  private

  def set_token
    @token = request.headers['Authorization'].blank? ? nil : request.headers['Authorization'].split(' ').last
  end
end
