require 'rubygems'
require 'google_spreadsheet'

module GoogleSpreadsheetImporter
  def self.import(model_class, key, gusername, gpassword, validate = true)
    puts "[START] import #{model_class}"
    session = GoogleSpreadsheet.login(gusername, gpassword)
    ws = session.spreadsheet_by_key(key).worksheets[0]
    site = Site.find_by_site_code(ws.title)
    columns = [:site_id]
    values = []
    for col in 1..ws.num_cols
      columns << ws[1, col].to_sym
    end

    for row in 2..ws.num_rows
      record = [site.id]
      for col in 1..ws.num_cols
        record << ws[row, col]
      end
      values << record
    end   

    model_class.import columns, values, :validate => validate
    puts "[END] import #{model_class}"
  end

  def self.import_sheet(model_class,worksheets, sheet_index)
    ws = worksheets[sheet_index]
    puts "[START] ----- import #{model_class} -----"
    site_code = ws.title.split("_").first
    site = Site.find_by_site_code(site_code)
    columns = [:site_id]
    values = []
    for col in 1..ws.num_cols
      columns << ws[1, col].to_sym
    end

    for row in 2..ws.num_rows
      record = [site.id]
      for col in 1..ws.num_cols
        record << ws[row, col]
      end
      values << record
    end   
    model_class.import columns, values, :validate => true 
    puts "[END] ----- import #{model_class} -----"
  end
end
