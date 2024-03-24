class Connection
  def self.cnaes_list
    begin
      response = RestClient.get("#{url_minera_data}/cnaes/list")
    rescue RestClient::ExceptionWithResponse => e
      raise Error::BadValueError.new("Ocorreu um erro entre a comunicação dos sistemas. Erro: "+ e.message)
    end
    raise Error::BadValueError.new("Tivemos problemas ao carregar a lista de CNAEs. Tente novamente mais tarde.")  unless response.blank? || response.code == 200
    body = JSON.parse(response.body)
    raise Error::BadValueError.new("#{body.erro}") if response.code != 200
    body['data']
  end

  def self.company_size_list
    begin
      response = RestClient.get("#{url_minera_data}/company_size/list")
    rescue RestClient::ExceptionWithResponse => e
      raise Error::BadValueError.new("Ocorreu um erro entre a comunicação dos sistemas. Erro: "+ e.message)
    end
    raise Error::BadValueError.new("Tivemos problemas ao carregar a lista. Tente novamente mais tarde.")  unless response.blank? || response.code == 200
    body = JSON.parse(response.body)
    raise Error::BadValueError.new("#{body.erro}") if response.code != 200
    body['data']
  end

  def self.municipality_from_uf(uf)
    begin
      response = RestClient.get("#{url_minera_data}/municipality_from_uf", params: {uf_code: uf})
    rescue RestClient::ExceptionWithResponse => e
      raise Error::BadValueError.new("Ocorreu um erro entre a comunicação dos sistemas. Erro: "+ e.message)
    end
    raise Error::BadValueError.new("Tivemos problemas ao carregar a lista de Municipios.")  unless response.blank? || response.code == 200
    body = JSON.parse(response.body)
    raise Error::BadValueError.new("#{body.erro}") if response.code != 200
    body['data']
  end

  def self.district_from_municipality(uf)
    begin
      response = RestClient.get("#{url_minera_data}/district_from_municipality", params: {municipality_code: uf})
    rescue RestClient::ExceptionWithResponse => e
      raise Error::BadValueError.new("Ocorreu um erro entre a comunicação dos sistemas. Erro: "+ e.message)
    end
    raise Error::BadValueError.new("Tivemos problemas ao carregar a lista de Bairros do Municipio.")  unless response.blank? || response.code == 200
    body = JSON.parse(response.body)
    raise Error::BadValueError.new("#{body.erro}") if response.code != 200
    body['data']
  end

  def self.find_county(code)
    begin
      response = RestClient.get("#{url_minera_data}/county/county_description", params: {county_code: code})
    rescue RestClient::ExceptionWithResponse => e
      raise Error::BadValueError.new("Ocorreu um erro entre a comunicação dos sistemas. Erro: "+ e.message)
    end
    raise Error::BadValueError.new("Tivemos problemas ao consultar o nome Municipio.")  unless response.blank? || response.code == 200
    body = JSON.parse(response.body)
    raise Error::BadValueError.new("#{body.erro}") if response.code != 200
    body['data']
  end 

  def self.find_company_size(code)
    begin
      response = RestClient.get("#{url_minera_data}company_size/company_size_description", params: {county_code: code})
    rescue RestClient::ExceptionWithResponse => e
      raise Error::BadValueError.new("Ocorreu um erro entre a comunicação dos sistemas. Erro: "+ e.message)
    end
    raise Error::BadValueError.new("Tivemos problemas ao consultar o Porte da Empresa.")  unless response.blank? || response.code == 200
    body = JSON.parse(response.body)
    raise Error::BadValueError.new("#{body.erro}") if response.code != 200
    body['data']
  end

  private

  def self.url_minera_data
    Figaro.env.minera_data
  end
end