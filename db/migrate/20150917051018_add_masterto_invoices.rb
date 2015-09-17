class AddMastertoInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :master, :boolean, default: false
  end
end
