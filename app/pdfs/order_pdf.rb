class OrderPdf < Prawn::Document
  def initialize(invoice)
    super(top_margin: 70)
    @invoice = invoice
    invoice_number
  end

  def invoice_number
    text "Invoice \##{@invoice.floor_area}"
  end




end