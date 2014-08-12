# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  before_action :get_latest_products
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
    registration_params = [:firstname, :lastname, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end


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