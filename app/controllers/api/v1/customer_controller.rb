class Api::V1::CustomerController < ApplicationController
  before_action :authenticated?, except: [:new]
  before_action :set_customer, only: [:update, :show, :delete, :leads_remaining]

  def list
    render json: {status: 200, message: 'Clientes listados com sucesso!', data: Customer.all}, status: :ok
  end

  def new
    begin
      customer = Customer.new_customer(customer_params)
      if customer
        CompaniesByCustomer.save_companies_by_customer(customer.id)
      end
      render json: { status: 201, message: "Criado com sucesso", data: customer }, status: :created, content_type: 'application/json'
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: [] }, status: :bad_request, content_type: 'application/json'
    end
  end

  def update
  end

  def show
  end

  def delete
  end

  def leads_remaining
    begin
      render json: { status: 200, message: 'Leads listados com sucesso!', data: CompaniesByCustomer.by_customer(@customer.id) }, status: :ok
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: [] }, status: :bad_request, content_type: 'application/json'
    end
  end

  private

  def set_customer
    byebug
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.permit(:first_name, :last_name, :email, :password, :status_id, :subscription_id)
  end
end
