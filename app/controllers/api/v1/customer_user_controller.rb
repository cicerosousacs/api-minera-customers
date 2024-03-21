class Api::V1::CustomerUserController < ApplicationController
  before_action :set_customer_user, only: [:update, :delete]

  def list
    render json: {status: 200, message: 'Usuários do Cliente listado com sucesso!', data: CustomerUser.all}, status: :ok
  end

  def new
    begin
      customer_user = CustomerUser.new_customer_user(customer_user_params)
      render json: { status: 201, message: "Criado com sucesso", data: customer_user }, status: :created, content_type: 'application/json'
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: [] }, status: :bad_request, content_type: 'application/json'
    end
  end

  def update
  end

  def delete
  end

  private

  def set_customer_user
    @customer_user = CustomerUser.find(params[:id])
  end

  def customer_user_params
    params.permit(:first_name, :last_name, :email, :password, :active, :customer_id)
  end
end
