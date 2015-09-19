class InvoicesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = current_user.invoices.all
  end

  def master
    @invoices = current_user.invoices.where("master = true")
  end

  def show
    @invoice = current_user.invoices.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice)
        send_data pdf.render, filename: "Invoice_#{@invoice.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def new
    @invoice = Invoice.new
  end

  def edit
  end

  def create
    @invoices = current_user.invoices.all
    @invoice = current_user.invoices.new(invoice_params)
    respond_to do |format|
      if @invoice.save
        flash[:success] = "Invoice was successfully created."
        format.html { redirect_to @invoice }
        format.json { render :show, status: :created, location: @invoice }  
        format.js { render action: 'create', status: :created, location: @invoice }
      else
        flash[:error] = "There was a problem creating the invoice."
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        flash[:success] = 'Invoice was successfully updated.'
        format.html { redirect_to @invoice }
        format.json { respond_with_bip(@invoice) }
      else
        flash[:error] = "There was a problem updating the invoice."
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice.destroy
    respond_to do |format|
      flash[:success] = 'Invoice was successfully destroyed.'
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
  end

  def import
    begin
      Invoice.import(params[:file])
      redirect_to invoices_path
    rescue
      flash[:error] = "Invalid CSV file format."
      redirect_to invoices_path
    end      
  end

  def sendinvoice
    @invoice = current_user.invoices.find(params[:id])
    InvoiceMailer.send_invoice(@invoice).deliver_now
    flash[:success] = 'Invoice was delivered.'
    redirect_to invoices_path
  end

  def refresh
    begin
      Invoice.refresh
      flash[:success] = 'Invoice was downloaded.'
      redirect_to invoices_path
    rescue Exception => e
      flash[:error] = "Google Spreadsheet download not working."
      redirect_to invoices_path
    end      
  end


  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:floor_id, :name, :floor_area, :deposit, :rent, :management_fee, :tax_1, :subtotal_1, :electric_fee, :tax_2, :subtotal_2, :water_fee, :tv_fee, :total, :invoice_month, :invoice_due_date, :electric_month, :rent_usage_date, :invoice_creation_date, :email)
    end
end
