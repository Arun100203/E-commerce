class HomeController < ApplicationController

    rescue_from Exception, with: :exception_handler

    def index
        @frequently_sold_products_details = Product.joins(:transactions).group(:id).order('count(transactions.product_id) desc').limit(16)
        @frequently_sold_products_1 = @frequently_sold_products_details.order("RANDOM()").limit(8)
        @frequently_sold_products_2 = Product.order("RANDOM()").limit(8)
        
        @gadget_categories = Category.find_by(category: "Gadgets")
        @gadgets = Product.where(category_id: @gadget_categories.id).order("RANDOM()").limit(8)
        
        @beauty_products_list = Category.find_by(category: "Household")
        @beauty_products = Product.where(category_id: @beauty_products_list.id).order("RANDOM()").limit(8)
    end

    def exception_handler(exception)
        if exception.is_a?(ActiveRecord::RecordNotFound)
            render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
        else
            render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false
        end
    end
    
end
