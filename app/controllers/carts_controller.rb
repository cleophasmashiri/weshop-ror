class CartsController < ApplicationController
  #before_action :authenticate_user!

  def show
    cart_ids = $redis.smembers current_user_cart_id
    @cart_products = Product.find(cart_ids)
  end


  def add    
    count = get_count() +1
    set_count count
    render json: count, status: 200
  end

  def remove
    count = get_count() -1
      set_count count
    render json: count, status: 200
  end
 

  #private
  def get_count
    begin     
      count_string = $redis.get current_user_cart_id
      if(count_string)
        count = JSON.parse(count_string)['count']
      else
        count = 0
      end      
    rescue
      count = 0
    end
  end
  def set_count new_count
    count = $redis.set current_user_cart_id, {"count"=> new_count}.to_json
  end
 
  def current_user_cart_id
    "cart#{session.id}"
  end
end
