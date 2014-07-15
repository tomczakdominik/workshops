class ReviewDecorator < Draper::Decorator
  delegate_all

  def author  
    return self.user.firstname.to_s + ' ' + self.user.lastname.to_s
  end

end
