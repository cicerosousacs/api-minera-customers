class SearchService
  def self.search(query)
    begin
      response = RestClient.get("#{url_minera_data}/search", params: query)
    rescue RestClient::ExceptionWithResponse => e
      raise Error::BadValueError.new("Ocorreu um erro entre a comunicação dos sistemas. Erro: "+ e.message)
    end

    raise Error::BadValueError.new("Tivemos problemas ao realizar sua consulta. Tente novamente mais tarde.")  unless response.code == 200

    body = JSON.parse(response.body)
    raise Error::BadValueError.new("#{body.erro}") if response.code != 200

    return body['total_query'], body['data']
  end

  private
  
  def self.url_minera_data
    Figaro.env.minera_data
  end
end