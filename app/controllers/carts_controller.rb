class CartsController < ApplicationController

    rescue_from Exception, with: :exception_handler

    def index
        @cart_items = Cart.where(customerinfo_id: current_customerinfo.id)
    end

    def new
        @cart = Cart.new
    end

    def create
        @cart = Cart.new(cart_params)
        if @cart.save
          redirect_to carts_path, notice: "Successfully Purchased the product.#{cart_params}"
        else
          redirect_to carts_path, notice: "Error Occurred during purchase."
        end
    end
    
    # for removing particular product from the cart
    def remove_from_cart
        @cart = Cart.find_by(customerinfo_id: current_customerinfo.id, product_id: params[:id])
        if @cart.destroy
          redirect_to carts_path, notice: "Product removed from the cart."
        else
          render :new, status: :not_found
        end
    end
    
    # for buying all the products in the cart
    def buy_all

        cart_items = Cart.where(customerinfo_id: current_customerinfo.id)
        account = Account.find_by(customerinfo_id: current_customerinfo.id)
        address = Address.find_by(customerinfo_id: current_customerinfo.id)

        if(address.nil? || account.nil?) 
          redirect_to "/profiles", notice: "Please add address and account details to proceed."
          return
        end

        location = address.door_no + ", " + address.street + ", " + address.state + ", " + address.country + ", " + address.pincode.to_s + "."

        # for each product in the cart, create a transaction
        cart_count = 1
        cart_items.each do |cart_item|
          @product = Product.find_by(cart_item.product_id)
          Transaction.create(customerinfo_id: current_customerinfo.id, product_id: @product.id, amount: @product.price, qty: cart_count, status: "Success", location: location, seller_id: @product.seller_id, account_id: account.id, date: Time.now.strftime("%d/%m/%Y %H:%M"))
          Product.find_by(@product.id).update(total_stock_amount: @product.total_stock_amount - 1, category_id:@product.category_id, type_id: @product.type_id)
        end

        # delete all the products from the cart
        if Cart.where(customerinfo_id: current_customerinfo.id).delete_all
          redirect_to carts_path, notice: "Products bought Successfull."
        else
          redirect_to carts_path, notice: "Error occured during purchase!", status: :not_found
        end
    end

    def exception_handler(exception)
      if exception.is_a?(ActiveRecord::RecordNotFound)
          render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
      else
          render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false
      end
    end
    
    private
    
    def cart_params
      params.require(:cart).permit(:name, :description, :brand, :price, :category, :total_stock_amount, :image, :customerinfo_id, :product_id)
    end
end
