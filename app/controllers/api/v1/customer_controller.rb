class Api::V1::CustomerController < ApplicationController
  before_action :authenticated?
  before_action :set_customer, only: [:update, :show, :delete]

  def list
    render json: {status: 200, message: 'Clientes listados com sucesso!', data: Customer.all}, status: :ok
  end

  def new
    begin
      user = Customer.new_customer(customer_params)
      render json: { status: 201, message: "Criado com sucesso", data: user }, status: :created, content_type: 'application/json'
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: e.message }, status: :bad_request, content_type: 'application/json'
    end
  end

  def update
  end

  def show
  end

  def delete
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.permit(:first_name, :last_name, :email, :password, :status_id, :subscription_id)
  end
end
