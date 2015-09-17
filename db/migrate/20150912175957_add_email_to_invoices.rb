class AddEmailToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :email, :string, default: "example@gmail.com"
  end
end
