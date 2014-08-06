# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  before_action :get_latest_products
  def get_latest_products
    @kupa = 'kupa'
    if Product.last(2)
    @last_added = Product.last(2) 
  else
    @last_added = ['Not enough products', 'Not enough products']
  end
  end
  

  def auth_user
    if user_signed_in?
      unless Product.find(params[:id]).user_id == current_user.id
        redirect_to category_product_path(params[:category_id], params[:id]), :error => 'You are not allowed to edit this product.'
        return false
      else
        return true
        
      end
    else
      return false
    end
  end

  def get_current_user
    if user_signed_in?
      @curr = current_user
    end
  end

  def authenticate_admin
    unless current_user.try(:admin?)
      # redirect_to new_user_session_path, :error => "Not an admin!"
      redirect_to new_user_session_path
      # , :error => "Not an admin!" === TO NIE ZADZIAUA
      flash[:error] = "You're not an admin"
      return false
      
    else
      return true
    end    
  end

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  protect_from_forgery with: :exception
end
  # def authenticate_recruit
  #   unless session[:recruit_id]
  #     redirect_to(:controller => 'recruit', :action => 'auth')
  #     return false
  #   else
  #     @current_recruit = Recruit.find session[:recruit_id] 
  #     return true
  #   end
  # end