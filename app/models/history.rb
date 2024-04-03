class History < ApplicationRecord
  HistoryObj = Struct.new(:id, :date_history, :hour_history, :name_list, :observation, :filters, :filters_params, :customer_user_id)

  def self.save_history(params)
    count_history = where('name_list like ?', "Lista Nº%").count
    history = History.new
    history.type_history = params[:query]
    history.date_history = Time.now
    history.name_list = params[:name].present? ? params[:name] : "Lista Nº #{count_history + 1}"
    history.observation = params[:observation]
    history.filters = params.to_json
    history.customer_user_id = params[:customer_id] if params[:customer_type] == 'CustomerUser'
    history.customer_id = params[:customer_type] == 'CustomerUser' ? CustomerUser.find(params[:customer_id]).customer_id : params[:customer_id]
    history.save!
    
    history
  end
  
  def self.list(params)
    if params[:type] == 'Customer'
      history = where(customer_id: params[:id]).order('id desc')
    else
      history = where(customer_user_id: params[:id]).order('id desc')
    end

    return [] if history.empty?
    mount_history(history)
  end

  def self.mount_history(history_query)
    filter = []
    history_query.each do |history|
      data = HistoryObj.new
      data.id = history.id
      data.date_history = (history.date_history - (3 * 60 * 60)).strftime("%Y-%m-%d")
      data.hour_history = (history.date_history - (3 * 60 * 60)).strftime("%H:%M:%S")
      data.name_list = history.name_list
      data.observation = history.observation
      data.filters = mount_filter(history.filters)
      data.filters_params = JSON.parse(history.filters)
      data.customer_user_id = history.customer_user_id
      filter << data
    end
    filter
  end

  def self.mount_filter(filter)
    fil = JSON.parse(filter)
    # Remove os pares chave-valor em que o valor é nulo
    fil.reject! { |key, value| 
      ["name", "observation", "query", "controller", "customer_id"].include?(key) || 
      ["historic", "result", "true", "Customer", "CustomerUser"].include?(value) || 
      value.nil? || value.empty?
    }
    # Mapeia os nomes das chaves para os nomes desejados
    nome_das_chaves = {
      "cnpj" => 'CNPJ',
      "company_name" => 'Razão Social',
      "fantasy_name" => 'Nome Fantasia',
      "company_size_code" => "Tipo de Empresa",
      "primary_cnae_code" => "Código CNAE Primário",
      "uf" => "Estado",
      "county_code" => "Cidade",
      "district" => "Bairro",
      "ddd" => "DDD",
      "simple_option" => "Optante do Simples",
      "mei_option" => "Optante do MEI",
      "email" => "E-mail",
      "initial_date" => "Data Início",
      "end_date" => "Data Final",
      "initial_share_capital" => "Capital Social Inicial",
      "end_share_capital" => "Capital Social Final",
      "quantity" => "Leads",
    }
    # Cria a string com os valores não nulos
    string = fil.map { |key, value| "#{nome_das_chaves[key]}: #{format_value(key, value)}" }.join(", ")
  
    string
  end

  def self.format_value(key, value)
    case key
    when 'primary_cnae_code'
      value.gsub(/,/, ', ')
    when 'county_code'
      Connection.find_county(value)
    when *%w[simple_option mei_option email]
      value == 'S' ? 'Sim' : 'Não'
    when *%w[initial_date end_date]
      Date.parse(value).strftime("%d/%m/%Y")
    when *%w[initial_share_capital end_share_capital]
      Money.new(value, "BRL").format(unit: "R$", separator: ",", delimiter: ".", format: "%u %n")
    when 'company_size_code'
      Connection.find_company_size(value)
    else
      value
    end
  end
end
