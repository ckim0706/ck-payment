require 'csv'

class Invoice < ActiveRecord::Base
  after_create :add_account_info

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      invoice_hash = row.to_hash
      Invoice.create(invoice_hash)
    end
  end

  private

  def add_account_info
    info = {"김성일"=>"443137-91-100082",
            "박삼인"=>"443102-01-227335",
            "김형선"=>"443102-01-227322"}

    self.account_location = "국민은행"
    
    case self.floor_id[0]
    when "1"
      self.account_number = info["김형선"]
      self.account_name = info.keys[2]
    when "2"
      self.account_number == info["박삼인"]
      self.account_name == info.keys[1]
    else
      self.account_number == info["김성일"]
      self.account_name == info.keys[0]
    end
  end
end
