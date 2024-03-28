class Api::V1::HistoryController < ApplicationController
  def search_history
    render json: {status: 200, message: 'Histórico listado com sucesso!', data: History.list(history_params[:id])}, status: :ok
  rescue StandardError => e
    render json: {status: 500, message: "Erro ao listar histórico: #{e.message}", data: []}, status: :internal_server_error
  end

  private

  def history_params
    params.permit(:id)
  end
end
