class Api::V1::ExportController < ApplicationController
  def export_to_xlsx
    params = remove_undefine_params(params_xlsx)
    filename = XlsxService.export_to_xlsx(params)
    if filename
      History.save_history(params).save! if params[:generate_list] == 'true'
      # CompaniesByCustomer.update_companies_by_customer(params[:customer_id], params[:quantity]) params[:generate_list] == 'true'
    end

    send_data File.read("/tmp/#{filename}"), type: "application/xlsx", filename: filename
  end

  private

  def params_xlsx
    params.permit(
      :name, :observation, :generate_list, :quantity, :cnpj, :fantasy_name, :company_name, :share_capital, :company_size_code, :primary_cnae_code, :uf, :county_code, 
      :district, :ddd, :simple_option, :mei_option, :email, :initial_date, :end_date, :initial_share_capital, :end_share_capital, :type, :customer_id
    )
  end

  def remove_undefine_params(params)
    keys_to_check = %i[name observation cnpj fantasy_name company_name company_size_code registration_situation_code primary_cnae_code uf 
      county_code district ddd simple_option mei_option email initial_share_capital end_share_capital initial_date end_date generate_list customer_id quantity
    ]
  
    sanitized_params = {}
  
    keys_to_check.each do |key|
      sanitized_params[key] = params[key] == "undefined" || params[key] == "null" ? '' : params[key]
    end
  
    return sanitized_params
  end
end
