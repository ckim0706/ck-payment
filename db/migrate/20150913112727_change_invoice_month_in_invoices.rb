class ChangeInvoiceMonthInInvoices < ActiveRecord::Migration
  def change
    change_column :invoices, :invoice_month, :string
  end
end
