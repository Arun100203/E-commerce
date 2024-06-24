class HomeController < ApplicationController

    # rescue_from Exception, with: :exception_handler

    def index
        # Fetch frequently sold products details
        @frequently_sold_products_details = Product.joins(:transactions)
        .group(:id)
        .order('count(transactions.product_id) desc')
        .limit(16)

        # Fetch frequently sold products randomly from the fetched details
        @frequently_sold_products_1 = @frequently_sold_products_details.order("RANDOM()").limit(8)

        # Fetch 8 random products if there are fewer than 8 frequently sold products
        if @frequently_sold_products_1.length < 8
            @frequently_sold_products_2 = Product.order("RANDOM()").limit(8)
        else
            @frequently_sold_products_2 = []
        end

        # Fetch gadgets category and related products
        @gadget_categories = Category.find_by(category: "Gadgets")
        if @gadget_categories
            @gadgets = Product.where(category_id: @gadget_categories.id).order("RANDOM()").limit(8)
        else
            @gadgets = []
        end

        # Fetch beauty products category and related products
        @beauty_products_list = Category.find_by(category: "Household")
        if @beauty_products_list
            @beauty_products = Product.where(category_id: @beauty_products_list.id).order("RANDOM()").limit(8)
        else
            @beauty_products = []
        end
    end

    def exception_handler(exception)
        if exception.is_a?(ActiveRecord::RecordNotFound)
            render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
        else
            render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false
        end
    end
    
end
