require 'csv'

class Invoice < ActiveRecord::Base

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      invoice_hash = row.to_hash
      Invoice.create!(invoice_hash)
    end
  end

end
