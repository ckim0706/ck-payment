require 'csv'

class Invoice < ActiveRecord::Base
  before_create :add_account_info
  before_save :invoice_tax_1, :invoice_tax_2, :invoice_subtotal_1, :invoice_subtotal_2, :invoice_total

  belongs_to :user

  def self.import(file)
    CSV.foreach(file.path, headers:true) do |row|
      invoice_hash = row.to_hash.slice(:floor_id, :name, :floor_area, :deposit, :rent, :management_fee, :tax_1, :subtotal_1, :electric_fee, :tax_2, :subtotal_2, :water_fee, :tv_fee, :total)
      Invoice.create!(invoice_hash)
    end
  end

  private
  # 부가세1
  def invoice_tax_1
    self.tax_1 = (self.rent + self.management_fee)/10
  end

  # 부가세2
  def invoice_tax_2
    self.tax_2 = self.electric_fee/10
  end

  # 소계(A)
  def invoice_subtotal_1
    self.subtotal_1 = self.rent + self.management_fee + self.tax_1
  end

  # 소계(B)
  def invoice_subtotal_2
    self.subtotal_2 = self.electric_fee + self.tax_2
  end

  # 총합계
  def invoice_total
    self.total = self.subtotal_1 + self.subtotal_2 + self.tv_fee + self.water_fee
  end

  def add_account_info
    self.account_location = "예시 은행"
    
    case self.floor_id[0]
    when "1"
      self.account_number = "123-1234-12345"
      self.account_name = "김님"
    when "2"
      self.account_number = "987-9876-98765"
      self.account_name = "박님"
    else
      self.account_number = "567-5678-56789"
      self.account_name = "하님"
    end
  end
end
