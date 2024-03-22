class Api::V1::HistoryController < ApplicationController
  def list
    render json: {status: 200, message: 'Histórico listado com sucesso!', data: History.list}, status: :ok
  end
end
