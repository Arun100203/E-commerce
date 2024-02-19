class CheckoutController < ApplicationController

    rescue_from Exception, with: :exception_handler

    def index
        @product = Product.find(params[:id])
        @account = Account.find_by(customerinfo_id: current_customerinfo.id)
        @address = Address.find_by(customerinfo_id: current_customerinfo.id)
    end

    # for buying the product
    def buy
        @product = Product.find(params[:id])
        qty = 1
        account_id = Account.find_by(customerinfo_id: current_customerinfo.id).id
        Transaction.create(customerinfo_id: current_customerinfo.id, product_id: @product.id, amount: @product.price, qty: qty, status: "Success", location: "Online", seller_id: @product.seller_id, account_id: account_id, date: Time.now.strftime("%d/%m/%Y %H:%M"))
        
        # update the stock amount of the product
        if @product.update(total_stock_amount: @product.total_stock_amount - 1, category_id:@product.category_id, type_id: @product.type_id)
            redirect_to root_path, notice: "Checkout Succesfully!!!..."
        else
            redirect_to root_path, notice: "Error Occurred in Checkout!!!."
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
    def checkout_params
        params.require(:checkout).permit(:product_id, :address_id, :account_id, :customer_id)
    end
end
