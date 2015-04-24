class InvoicePdf < Prawn::Document

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
    text "청구서", size: 18, align: :center
    invoice_to
    recipient
    payment_due_date
  end


  
  def invoice_to
    move_down 20
    text "#{@invoice.floor_id} 호"
  end

  def recipient 
    move_up 10
    text "#{@invoice.name} 귀하", align: :right
  end

  def payment_due_date
    text ""
  end

#------------------------------------------------------

  def body
    move_down 50
    invoice_table
  end

  def invoice_table
    data = [[{:content => "항목", :colspan => 2}, {:content => "금액", :colspan => 2}],
            [{:content => "임대료 관리비", :rowspan => 4}, "임대료", {:content => "#{@invoice.rent}", :colspan => 2}],
            ["관리비", {:content => "#{@invoice.management_fee}", :colspan => 2} ],
            ["부가세1", {:content => "#{@invoice.tax_1}", :colspan => 2} ],
            ["소계(A)", {:content => "#{@invoice.subtotal_1}", :colspan => 2} ],

            [{:content => "전기료", :rowspan => 3}, "전기료", {:content => "#{@invoice.electric_fee}", :colspan => 2}],
            ["부가세2", {:content => "#{@invoice.tax_2}", :colspan => 2} ],
            ["소계(B)", {:content => "#{@invoice.subtotal_2}", :colspan => 2} ],
            [{:content => "상하수도료", :colspan => 2}, {:content => "#{@invoice.water_fee}", :colspan => 2}],
            [{:content => "dynamic variable", :colspan => 2}, {:content => "nothing yet", :colspan => 2}],
            [{:content => "당월부과액", :colspan => 2}, {:content => "#{@invoice.water_fee}", :colspan => 2}],
            [{:content => "미납연체료", :colspan => 2}, {:content => "#{@invoice.water_fee}", :colspan => 2}],
            [{:content => "납기내금액", :colspan => 2}, {:content => "#{@invoice.water_fee}", :colspan => 2}]]

    table data, :cell_style => { :width => 100 }, 
                :position => :center
  end

#------------------------------------------------------

  def footer
    move_down 20
    account_info
    late_fee_warning
    created_at
    brand
  end

  def account_info
    move_down 20
    text "위 금액을 #{@invoice.account_location} #{@invoice.account_number} (#{@invoice.account_name}) 계좌로 입금시켜 주시기 바랍니다.", align: :center
  end

  def late_fee_warning
    move_down 20
    text "납기일 경과시 3% 연체료가 부과됩니다.", size: 10, align: :center
  end

  def created_at
    move_down 20
    text "", align: :center
  end

  def brand
    move_down 20
    text "만수빌딩 대표   김 성일", align: :center
  end

end