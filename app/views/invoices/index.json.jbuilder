json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :floor_id, :name, :floor_area, :deposit, :rent, :management_fee, :tax_1, :subtotal_1, :electric_fee, :tax_2, :subtotal_2, :water_fee, :tv_fee, :total
  json.url invoice_url(invoice, format: :json)
end
