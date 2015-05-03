module CartsHelper

  def cart_count 
    cart_items = get_cart_items
    cart_items ? cart_items.size : 0
  end

  def cart_total_price
    total_price = 0
    get_cart_products.each { |product| total_price+= product.price}  
    total_price
  end

  def get_cart_products 
    cart_ids = get_cart_items 
    @cart_products = Product.find(cart_ids)   
  end

  def purchase_cart_products!
      products = get_cart_products
      products.each  do  |product| 
        purchase product
      end
      $redis.del current_user_cart_id
  end

  def purchase(product)
    object = Purchase.new(:product_id=>product.id, :user_id=>current_user.id)
    object.save
  end

  def purchase?(product)
    products.include?(product)
  end


   def get_cart  cart_id
    cart_id = cart_id ? cart_id : current_user_cart_id 
      cart_string = $redis.get cart_id
      if(cart_string)
        @cart = JSON.parse(cart_string)
      else
        @cart = {'cart_id'=>cart_id, 'cart_items'=>''}        
      end  
  end
  
  def get_cart_items
    cart = get_cart current_user_cart_id
    cart_items_string = cart['cart_items']
    ids = cart_items_string ? cart_items_string.split(',') : nil   
  end

  def set_cart_items product_id
    cart_items = get_cart_items
    cart_items ? cart_items.push(product_id) : Array.new(1) {product_id} 
  end

  def delete_cart_item product_id
    cart_items = get_cart_items
    if cart_items 
     cart_items.pop(product_id.to_i)  
    end
  end

  def current_user_cart_id
    "cart#{session.id}"
  end
end
