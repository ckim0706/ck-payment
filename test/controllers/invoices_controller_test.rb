require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  setup do
    @invoice = invoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoice" do
    assert_difference('Invoice.count') do
      post :create, invoice: { deposit: @invoice.deposit, electric_fee: @invoice.electric_fee, floor_area: @invoice.floor_area, floor_id: @invoice.floor_id, management_fee: @invoice.management_fee, name: @invoice.name, rent: @invoice.rent, subtotal_1: @invoice.subtotal_1, subtotal_2: @invoice.subtotal_2, tax_1: @invoice.tax_1, tax_2: @invoice.tax_2, total: @invoice.total, tv_fee: @invoice.tv_fee, water_fee: @invoice.water_fee }
    end

    assert_redirected_to invoice_path(assigns(:invoice))
  end

  test "should show invoice" do
    get :show, id: @invoice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invoice
    assert_response :success
  end

  test "should update invoice" do
    patch :update, id: @invoice, invoice: { deposit: @invoice.deposit, electric_fee: @invoice.electric_fee, floor_area: @invoice.floor_area, floor_id: @invoice.floor_id, management_fee: @invoice.management_fee, name: @invoice.name, rent: @invoice.rent, subtotal_1: @invoice.subtotal_1, subtotal_2: @invoice.subtotal_2, tax_1: @invoice.tax_1, tax_2: @invoice.tax_2, total: @invoice.total, tv_fee: @invoice.tv_fee, water_fee: @invoice.water_fee }
    assert_redirected_to invoice_path(assigns(:invoice))
  end

  test "should destroy invoice" do
    assert_difference('Invoice.count', -1) do
      delete :destroy, id: @invoice
    end

    assert_redirected_to invoices_path
  end
end
