require 'csv'

class Invoice < ActiveRecord::Base
  before_create :check_admin

  belongs_to :user

  # def self.import(file)
  #   CSV.foreach(file.path, headers:true) do |row|
  #     invoice_hash = row.to_hash
  #     Invoice.create!(invoice_hash)
  #   end
  # end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      invoice_hash = row.to_hash
      Invoice.create!(invoice_hash)
    end
  end


  private

  def check_admin
    p current_user
    if current_user == User.find_by(email: ENV["GMAIL"])
      add_account_info
    end
  end 

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
