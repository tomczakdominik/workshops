class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  
  # def author
  #   return self.user.firstname.to_s + ' ' + self.user.lastname.to_s
  # end
end
