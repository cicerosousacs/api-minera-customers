class Api::V1::SelectController < ApplicationController
  def cnaes
    cnaes = Connection.cnaes_list
    render json: {status: 200, message: "Lista de CNAEs carregada com sucesso", data: cnaes}
  end

  def company_size
    company_size = Connection.company_size_list
    render json: {status: 200, message: "Lista de Porte de Empresas carregada com sucesso", data: company_size}
  end

  def municipality_from_uf
    uf = uf_params[:uf]
    municipality = Connection.municipality_from_uf(uf)
    render json: {status: 200, message: "Lista de Municipios carregada com sucesso", data: municipality}
  end

  def district_from_municipality
    municipality_code = municipality_params[:municipality_code]
    district = Connection.district_from_municipality(municipality_code)
    render json: {status: 200, message: "Lista de Bairros carregada com sucesso", data: district}
  end

  private

  def uf_params
    params.permit(:uf)
  end

  def municipality_params
    params.permit(:municipality_code)
  end
end
