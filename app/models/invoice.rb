require 'csv'

class Invoice < ActiveRecord::Base
  before_create :add_account_info

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      invoice_hash = row.to_hash
      Invoice.create!(invoice_hash)
    end
  end

  private

  def add_account_info
    self.account_location = ENV["b_name"]
    
    case self.floor_id[0]
    when "1"
      self.account_number = ENV["b_3_info"]
      self.account_name = ENV["b_3_name"]
    when "2"
      self.account_number = ENV["b_2_info"]
      self.account_name = ENV["b_2_name"]
    else
      self.account_number = ENV["b_2_info"]
      self.account_name = ENV["b_1_name"]
    end
  end
  
end
