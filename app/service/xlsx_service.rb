class XlsxService
  def self.export_to_xlsx(params)
    result = SearchService.search(params)

    filename = params[:name].present? ? params[:name].gsub(' ', '_') : "Lista-#{Time.now.strftime("%d%m%Y%H%M")}.xlsx"
    workbook = WriteXLSX.new("/tmp/#{filename}")
    worksheet = workbook.add_worksheet
    
    format_headers = workbook.add_format
    format_headers.set_bold
    format_headers.set_color('black')
    format_headers.set_align('center')

    format_col = workbook.add_format
    format_col.set_align('center')

    date_format = workbook.add_format(num_format: 'dd/mm/yy')

    worksheet.set_column(0, 0, 55)
    worksheet.set_column(1, 1, 15)
    worksheet.set_column(2, 2, 40)
    worksheet.set_column(3, 3, 30)
    worksheet.set_column(4, 4, 30)
    worksheet.set_column(5, 5, 20)
    worksheet.set_column(6, 6, 15)

    worksheet.write(0, 0, "Razão Social", format_headers)
    worksheet.write(0, 1, "Telefone", format_headers)
    worksheet.write(0, 2, "E-mail", format_headers)
    worksheet.write(0, 3, "Pessoa de Contato", format_headers)
    worksheet.write(0, 4, "Observação", format_headers)
    worksheet.write(0, 5, "Data de Abertura", format_headers)
    worksheet.write(0, 6, "Situação", format_headers)

    i = 1

    result[1].each do |re|
      worksheet.write(i, 0, re['fantasy_name'])
      worksheet.write(i, 1, "(#{re['telephone_one'][0, 2]}) #{re['telephone_one'][2, 4]}-#{re['telephone_one'][6, 4]}", format_col)
      worksheet.write(i, 2, re['email'])
      worksheet.write(i, 3, '')
      worksheet.write(i, 4, '')
      worksheet.write(i, 5, re['date_status_registration'] == '0' ? '-' : Date.strptime(re['date_status_registration'], "%Y%m%d").strftime("%d/%m/%Y"), format_col)
      worksheet.write(i, 6, re['registration_situation'], format_col)
      i += 1
    end

    workbook.close

    file = filename
  end
end