class Api::V1::SearchController < ApplicationController
  before_action :authenticated?
  
  def search
    params = remove_undefine_params(search_params)
    if search_params[:type] == 'unique'
      check_search_uniq_params(params)
    else
      check_search_params(params)
    end
    total, search = SearchService.search(params)
    render json: {status: 200, message: "Consulta realizada com sucesso", total_query: total, data: search }
  rescue StandardError => e
    render_error_response(e, :bad_request)
  rescue ExceptionWithResponse
    render_error_response('Erro ao Minerar Dados', :internal_server_error)
  end

  private

  def search_params
    params.permit(
      :generate_list, :quantity, :cnpj, :fantasy_name, :company_name, :share_capital, :company_size_code, :primary_cnae_code, :uf, :county_code, 
      :district, :ddd, :simple_option, :mei_option, :email, :initial_date, :end_date, :initial_share_capital, :end_share_capital, :type, :customer_id
    )
  end

  def remove_undefine_params(params)
    keys_to_check = %i[
      generate_list quantity cnpj fantasy_name company_name share_capital company_size_code primary_cnae_code uf county_code 
      district ddd simple_option mei_option email initial_date end_date initial_share_capital end_share_capital type customer_id
    ]
  
    sanitized_params = {}
  
    keys_to_check.each do |key|
      
      sanitized_params[key] = params[key] == "undefined" || params[key] == "null" ? '' : params[key]
    end
  
    return sanitized_params
  end

  def check_search_uniq_params(params)
    unless params[:cnpj].present? || params[:fantasy_name].present? || params[:company_name].present?
      raise 'Informe pelo menos um dos seguintes campos: CNPJ, Nome Fantasia ou Razão Social'
    end
  end

  def check_search_params(params)
    required_params = %i[
      generate_list quantity cnpj fantasy_name company_name share_capital company_size_code primary_cnae_code uf county_code 
      district ddd simple_option mei_option email initial_date end_date initial_share_capital end_share_capital type customer_id
    ]
  
    if required_params.none? { |param| params[param].present? }
      raise 'Informe pelo menos um campo para consulta'
    end
  end

  def render_error_response(message, status)
    render json: { message: message }, status: status
  end
end
