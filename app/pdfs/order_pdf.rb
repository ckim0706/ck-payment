class OrderPdf < Prawn::Document

  TABLE_ROW_COLORS = ["FFFFFF","DDDDDD"]
  TABLE_FONT_SIZE = 9
  TABLE_WIDTHS = [20, 100, 30, 60]
  
  def initialize(invoice)
    super(top_margin: 70)
    @invoice = invoice
    font_update
    
    header
    body
    footer
  end

#------------------------------------------------------

  def font_update
    font_families.update(
      "Unbatang" => { :normal => Rails.root.join('app/assets/fonts/unbatang.ttf').to_s,
                      # :normal => Rails.root.join('app/assets/fonts/unbatangbold.ttf').to_s 
                    }
    )
    font "Unbatang"
  end

#------------------------------------------------------
  
  def header
    text "청구서"
    invoice_to
    recipient
    payment_due_date
  end
  
  def invoice_to
    text "#{@invoice.floor_id}"
  end

  def recipient 
    text "#{@invoice.name} 귀하"
  end

  def payment_due_date
    text ""
  end

#------------------------------------------------------

  def body
    invoice_table
  end

  def invoice_table
    data = [ ["임대료", @invoice.rent],
             ["관리비", @invoice.management_fee],
             ["부가세1", @invoice.tax_1],
             ["소계(A)", @invoice.subtotal_1],
             ["전기료", @invoice.electric_fee],
             ["부가세2", @invoice.tax_2],
             ["소계(B)", @invoice.subtotal_2],
             ["상하수도료", @invoice.water_fee],
             ["TV", @invoice.tv_fee],
             ["당월부과액", @invoice.total],
             ["미납금액", @invoice.total],
             ["납기금", @invoice.total], ]
    table data
  end

#------------------------------------------------------

  def footer
    account_info
    late_fee_warning
    created_at
    brand
  end

  def account_info
    move_down 20
    text "위 금액을 #{@invoice.account_location} #{@invoice.account_number} (#{@invoice.account_name}) 계좌로 입금시켜 주시기 바랍니다."
  end

  def late_fee_warning
    move_down 20
    text "납기일 경과시 3% 연체료가 부과됩니다."
  end

  def created_at
    move_down 20
    text ""
  end

  def brand
    move_down 20
    text "만수빌딩 대표   김 성일"
  end

end