class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart!
  
  def new
    gon.client_token = generate_client_token
  end

  def create
    @result = Braintree::Transaction.sale(amount: cart_total_price, payment_method_nonce: params[:payment_method_nonce])
    if @result.success?
      purchase_cart_products!
      redirect_to root_url, notice: "Congraulations! Your transaction has been successfully!"
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      render :new
    end
  end

  private

  include CartsHelper

  def check_cart!
    cart_items = get_cart_items
    if !cart_items || cart_items.size < 1
      redirect_to root_url, alert: "Please add some items to your cart before you checkout"
    end    
  end

  def generate_client_token
    Braintree::ClientToken.generate
  end

end
