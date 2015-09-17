class AddDetailsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :invoice_month, :integer, default: "2015년 1월 30일"
    add_column :invoices, :invoice_due_date, :string, default: "1월 30일"
    add_column :invoices, :electric_month, :string, default: "1/1 ~ 1/30"
    add_column :invoices, :rent_usage_date, :string, default: "1/1 ~1/30"
    add_column :invoices, :invoice_creation_date, :string, default: "1월 30일"
  end
end
