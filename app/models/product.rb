class Product < ActiveRecord::Base
  has_many :line_items
  attr_accessible :title, :description, :image_url, :price
  validates_presence_of :title, :description, :image_url
  validates_numericality_of :price
  validate :price_must_be_at_least_a_cent
  validates_uniqueness_of :title
  validates_format_of :image_url,
                      :with => %r{\.(gif|jpg|png)$}i,
                      :message => 'not GIF JPG PNG image'

protected 
def price_must_be_at_least_a_cent
  errors.add(:price, 'not less than 0.01') if price.nil?|| price < 0.01
 

end

def self.find_products_for_sale
  find(:all, :order => "title")

end


end
