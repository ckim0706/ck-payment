class OrderPdf < Prawn::Document
  
  def initialize(invoice)
    super(top_margin: 70)
    @invoice = invoice
    font_update
    
    header
    invoice_number


    account
    footer    
  end

  def font_update
    font_families.update(
      "Unbatang" => { :normal => Rails.root.join('app/assets/fonts/unbatang.ttf').to_s,
                      # :normal => Rails.root.join('app/assets/fonts/unbatangbold.ttf').to_s 
                    }
    )
    font "Unbatang"
  end

  def invoice_number
    text "청구서 \##{@invoice.floor_id} #{@invoice.name}"
  end

  def header
    text "청구서"
  end

  def recipient 
    text "#{@invoice.name}"
  end

  def payment_due_date
    text ""
  end



  def account
    text "위 금액을 #{@invoice.account_location} #{@invoice.account_number} (#{@invoice.account_name}) 계좌로 입금시켜 주시기 바랍니다."
  end


  def footer
    text "만수빌딩 대표   김 성일"
  end


end