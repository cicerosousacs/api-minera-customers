class Api::V1::CustomerUserController < ApplicationController
  before_action :authenticated?
  before_action :set_customer_user, only: [:update, :edit]

  def list
    render json: {status: 200, message: 'Usuários do Cliente listado com sucesso!', data: CustomerUser.by_customer(list_params[:id])}, status: :ok
  end

  def new
    begin
      customer_user = CustomerUser.new_customer_user(customer_user_params)
      render json: { status: 201, message: "Usuário criado com sucesso", data: customer_user }, status: :created, content_type: 'application/json'
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: [] }, status: :bad_request, content_type: 'application/json'
    end
  end

  def edit
    begin
      render json: { status: 200, message: 'Usuário do Cliente carregado com sucesso!', data: @customer_user }, status: :ok, content_type: 'application/json'
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: [] }, status: :bad_request, content_type: 'application/json'
    end
  end

  def update
    begin
      customer_user = CustomerUser.update_customer_user(@customer_user, customer_user_update_params)
      render json: { status: 200, message: 'Usuário atualizado com sucesso!', data: customer_user }, status: :ok
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: [] }, status: :bad_request
    end
  end

  def enable_disable
    begin
      customer_user = CustomerUser.enable_disable(customer_user_status_params[:customer_user_id], customer_user_status_params[:status])
      render json: { status: 200, message: 'Status alterado com sucesso!', data: customer_user }, status: :ok
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: [] }, status: :bad_request
    end
  end

  def select_customer_users
    begin
      select = CustomerUser.select_customer_users(list_params[:id])
      render json: { status: 200, message: 'Select de Cliente carregado com sucesso!', data: select }, status: :ok
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: [] }, status: :bad_request
    end
  end

  private

  def set_customer_user
    @customer_user = CustomerUser.find(params[:id])
  end

  def list_params
    params.permit(:id)
  end

  def customer_user_params
    params.permit(:first_name, :last_name, :email, :password, :customer_id)
  end

  def customer_user_update_params
    params.permit(:first_name, :last_name, :email, :password)
  end

  def customer_user_status_params
    params.permit(:customer_user_id, :status)
  end
end
