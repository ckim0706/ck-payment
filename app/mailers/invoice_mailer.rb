class InvoiceMailer < ActionMailer::Base
  default from: 'chuckiee_kim@hotmail.com'

  def send_invoice(invoice)
      pdf = InvoicePdf.new(invoice, view_context)   # I assume that you have already created the class to generate PDF
      attachments['ticket.pdf'] = {
         :content => pdf.render,
         :mime_type => 'application/pdf'
      }
     mail(to: "#{invoice.customer.email}",
         subject: "Invoice ##{invoice.id} dated on #{invoice.purchase_date}")
  end

end