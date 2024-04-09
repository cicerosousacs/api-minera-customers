class Api::V1::AuthController < ApplicationController
  before_action :set_customer, only: [:change_password]

  def sign_in
    customer = AuthenticateCustomer.new(params[:email], params[:password]).call
    if customer
      token = Session.new_session(customer)
      render json: { status: 200, message: 'Autenticado com sucesso!', data: { token: token } }, status: :ok, content_type: 'application/json'
    end
  rescue StandardError => e
    render json: { status: 400, message: e.message, data: [] }, status: :bad_request, content_type: 'application/json'
  end

  def sign_out
    begin
      Session.destroy_session(@token)
      render json: { status: 200, message: "Deslogado com sucesso" }, status: :ok, content_type: 'application/json'
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: [] }, status: :bad_request, content_type: 'application/json'
    end
  end

  def change_password #123Mud@r
    if @customer.authenticate(params[:current_password])
      if params[:customer_type] == 'Customer'
        Customer.change_password(params[:current_password], params[:new_password], @customer)
        render json: { status: 200, message: "Senha alterada com sucesso!" }, status: :ok, content_type: 'application/json'
      else
        CustomerUser.change_password(params[:current_password], params[:new_password], @customer)
        render json: { status: 200, message: "Senha alterada com sucesso!" }, status: :ok, content_type: 'application/json'
      end
    else
      render json: { status: 400, message: 'A Senha atual não confere!' }, status: :unprocessable_entity
    end
  end

  def forgot_password
    Customer.validation_generate_token(forgot_password_params[:email])
    render json: { status: 200, message: "Email enviado para #{forgot_password_params[:email]}." }, status: :ok, content_type: 'application/json'
  rescue StandardError => e
    render json: { status: 400, message: e.message }, status: :unprocessable_entity
  end

  def reset_password
    Customer.reset_password(reset_password_params)
    # byebug
    render json: { status: 200, message: "Senha alterada com sucesso!" }, status: :ok, content_type: 'application/json'
  rescue StandardError => e
    render json: { status: 400, message: e.message }, status: :unprocessable_entity
  end

  private

  def set_customer
    if params[:customer_type] == 'Customer'
      @customer = Customer.find(params[:id])
    else
      @customer = CustomerUser.find(params[:id])
    end
  end

  def change_password_params
    params.permit(:current_password, :new_password, :confirm_password)
  end

  def forgot_password_params
    params.permit(:email)
  end

  def reset_password_params
    params.permit(:email, :newPassword, :confirmPassword, :token)
  end
end
