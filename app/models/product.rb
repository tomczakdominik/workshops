class Product < ActiveRecord::Base
  validates_presence_of :title
  # validates_presence_of :user_id
  validates_presence_of :description
  validates_presence_of :price
  validates_format_of :price, :with => /\A^\d+\.?\d{0,2}\z/
  belongs_to :category
  belongs_to :user
  has_many :reviews
  # lol = 2
  def average_rating()
    # a = Product.find(id).review.last
    sum = 0
    # r = Review.where(:product_id => self.id)
    # r = Product.find(self.id).reviews
    r = self.reviews
    r.each do |a|
      sum += a.rating
      # print sum
    end
    return (sum.to_f / r.length.to_f)
    # return sum
  end
end

