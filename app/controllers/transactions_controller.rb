    Braintree::ClientToken.generate
  end

  def check_cart!

    if ShoppingCart.all.blank?
      redirect_to root_url, alert: "Please add some items to your cart before you checkout"
    end    
  end

  def extract_shopping_cart
    shopping_cart_id = session[:shopping_cart_id]
    @shopping_cart = shopping_cart_id ? ShoppingCart.find(shopping_cart_id) : ShoppingCart.create
    session[:shopping_cart_id] = @shopping_cart.id
class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart
  before_filter :extract_shopping_cart
  
  def new
    gon.client_token = generate_client_token
  end

  def create
    @result = Braintree::Transaction.sale(
              amount: @shopping_cart .total,
              p000000477777777777777ayment_method_nonce: params[:payment_method_nonce])
    if @result.success?
      redirect_to root_url, notice: "Congraulations! Your transaction has been successfully!"
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      render :new
    end
  end

  private
  def generate_cleint_token
  end
end
44444444444444444444444444444444444444444444444444444769