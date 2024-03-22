class History < ApplicationRecord
  HistoryObj = Struct.new(:id, :date_history, :name_history, :observation, :filters, :filters_params)

  def self.save_history(params)
    count_history = where('name_history like ?', "Lista Nº%").count
    history = History.new
    history.type_history = params[:query]
    history.date_history = Time.now
    history.observation = params[:observation]
    history.name_history = params[:name].present? ? params[:name] : "Lista Nº #{count_history + 1}"
    history.filters = params.to_json
    history.user_id = ''
    history
  end
  
  def self.list
    history = order('id desc')
    mount_history(history)
  end

  def self.mount_filter(filter)
    fil = JSON.parse(filter)
    # Remove os pares chave-valor em que o valor é nulo
    fil.reject! { |key, value| key == "name" || key == "observation" || key == "query" || key == 'controller' || value.nil? || value.empty? || value == 'search_uniq' || value == 'search'}
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
      "end_share_capital" => "Capital Social Final"
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
      County.find_by_code(value).description
    when *%w[simple_option mei_option email]
      value == 'S' ? 'Sim' : 'Não'
    when *%w[initial_date end_date]
      Date.parse(value).strftime("%d/%m/%Y")
    when *%w[initial_share_capital end_share_capital]
      Money.new(value, "BRL").format(unit: "R$", separator: ",", delimiter: ".", format: "%u %n")
    when 'company_size_code'
      CompanySize.find_by_code(value).description
    else
      value
    end
  end
end
