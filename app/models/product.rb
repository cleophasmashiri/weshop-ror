class Product < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "400x600#", :thumb => "320x150>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  has_many :purchases
  has_many :users, through: :purchases

  def cart_action(current_user_id)
    if $redis.sismember "cart#{current_user_id}", id
      "Remove from"
    else
      "Add to"
    end  
  end

end
