class Product < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "400x600#", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  has_many :purchases
  has_many :users, through: :purchases

end
