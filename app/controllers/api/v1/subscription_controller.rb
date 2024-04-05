class Api::V1::SubscriptionController < ApplicationController
  before_action :authenticated?
  
  def list
    begin
      render json: {status: 200, message: 'Planos de Assinatura listados com sucesso!', data: Subscription.list}, status: :ok
    rescue StandardError => e
      render json: {status: 400, message: e.message, data: []}, status: :bad_request
    end
  end
end
