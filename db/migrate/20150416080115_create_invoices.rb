class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :floor_id
      t.string :name
      t.integer :floor_area
      t.integer :deposit
      t.integer :rent
      t.integer :management_fee
      t.integer :tax_1
      t.integer :subtotal_1
      t.integer :electric_fee
      t.integer :tax_2
      t.integer :subtotal_2
      t.integer :water_fee
      t.integer :tv_fee
      t.integer :total

      t.timestamps null: false
    end
  end
end
