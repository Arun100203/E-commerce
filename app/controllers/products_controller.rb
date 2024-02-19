class ProductsController < ApplicationController
    
    before_action :set_product, only: [:edit, :update, :show, :destroy]
    rescue_from Exception, with: :exception_handler

    def new
      @product = Product.new
    end

    def index
      @products = Product.all
    end 
    
    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to product_path(@product), notice: "Product was successfully created." 
      else
        flash[:alert] = @product.errors.full_messages
        render :new, status: :unprocessable_entity 
      end
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to product_path(@product.id), notice: 'Product was successfully updated.'
      else
        redirect_to product_path(@product.id), notice: 'Error updating product.'
      end
    end

    # for adding product to the cart
    def add_to_cart       
      @cart = Cart.new(customerinfo_id:current_customerinfo.id, product_id: params[:id])
      if @cart.save
        redirect_to carts_path, notice: "Product added to the cart."
      else
        redirect_to carts_path, notice: "Error adding product to the cart."
      end
    end

    def destroy
      if @product.destroy
        redirect_to root_path, notice: "Product was successfully deleted."
      else
        redirect_to product_path(product_params[:id]), notice: "Error deleting product."
      end
    end

    def show
      @comments = @product.comments
    end

    # for handling the all types of exceptions
    def exception_handler(exception)
      if exception.is_a?(ActiveRecord::RecordNotFound)
          render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
      else
          render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false
      end
  end
  
    def set_product
      @product = Product.find(params[:id])
    end

    private
  
    def product_params
      params.require(:product).permit(:name, :description, :brand, :price, :category_id, :type_id, :total_stock_amount, :seller_id, :image)
    end      
end
