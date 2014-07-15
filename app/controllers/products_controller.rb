class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:update, :create, :destroy]
  # before_action :auth_user, only: [:update, :edit, :destroy]
  before_action :get_current_user
  expose(:category)
  expose(:products)
  expose(:product)
  expose(:review) { Review.new }
  expose_decorated(:reviews, ancestor: :product)

  def index
    products = Product.all
  end

  def show
  end

  def new
  end

  def edit
    # @eko = session
    # @eko = session
    # @eko.each do |e|
    wpis = self.product.attributes.to_s
    # @eko = @current_
    if user_signed_in?
      if Product.find(params[:id]).user_id != current_user.id
        redirect_to category_product_path(params[:category_id], params[:id]), :flash => { :error => 'You are not allowed to edit this product.' }
        # flash[:error] = 'You are not allowe1d to edit this product.'
      else
        flash[:error] = 'else wewn '+wpis+' ok.'+current_user
      end         
    end
    
    # self.product = Product.find(params[:id])
    # p = Product.find(params[:id])
    
    # @ses_id = 213

  end

  def create
    self.product = Product.new(product_params)

    if product.save
      category.products << product
      redirect_to category_product_url(category, product), notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update      
    if user_signed_in?
      if Product.find(params[:id]).user_id != current_user.id
        redirect_to category_product_path(params[:category_id], params[:id]), :flash => { :error => 'You are not allowed to edit this product.' }
      else
        if self.product.update(product_params)
          redirect_to category_product_url(category, product), notice: 'Product was successfully updated.'
        else
          render action: 'edit'
        end
      end         
    end
    # if self.product.update(product_params)
    #   redirect_to category_product_url(category, product), notice: 'Product was successfully updated.'
    # else
    #   render action: 'edit'
    # end
    
  end

  # DELETE /products/1
  def destroy
    product.destroy
    redirect_to category_url(product.category), notice: 'Product was successfully destroyed.'
  end

  private
    def product_params
      params.require(:product).permit(:title, :description, :price, :category_id)
    end
end
