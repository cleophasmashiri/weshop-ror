module ProductsHelper

  def get_cart_action(product)
    id = product.id
    return product.cart_action current_user.try :id
  end

end
