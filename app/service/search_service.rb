class SearchService
  def self.search(query)
    begin
      # response = RestClient.get("#{url_minera_data}/search", params: query, timeout: 2000, open_timeout: 2000, headers: { Authorization: bearer })
      response = RestClient.get("#{url_minera_data}/search", params: query, timeout: 2000, open_timeout: 2000)
    rescue RestClient::ExceptionWithResponse => error
      raise ("Ocorreu um erro entre a comunicação dos sistemas. Erro: "+ error.message)
    end

    raise ("Tivemos problemas ao realizar sua consulta. Tente novamente mais tarde.")  unless response.code == 200

    body = JSON.parse(response.body)
    raise ("#{body.erro}") if response.code != 200

    return body['total_query'], body['data']
  end

  private
  
  def self.url_minera_data
    Figaro.env.minera_data
  end
end