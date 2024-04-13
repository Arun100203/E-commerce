module Api::V1
        class ProductsController < BaseController
            
            # for API calls
            before_action  :set_product, only: [ :update]
            before_action :check_resource_owner, only: [:create, :update, :destroy, :index, :show, :set_product]
            before_action :check_custom_api_resource_owner, only: [:product_sold_count]
            rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

            def index
                products = []
                Product.all.each do |product|
                    product_hash = {
                        id: product.id,
                        name: product.name,
                        description: product.description,
                        brand: product.brand,
                        price: product.price,
                        category_id: product.category_id,
                        type_id: product.type_id,
                        total_stock_amount: product.total_stock_amount,
                        seller_id: product.seller_id,
                        image_url: url_for(product.image)
                      }
                      products << product_hash
                end
                render json: products
            end

            # Custom API controller 
            def product_sold_count
                # @product_with_joins = Product.joins(:transactions).group(:id).order('count(transactions.product_id) desc').count
                @product_with_joins = Transaction.joins(:product)
                @product_with_includes = Transaction.includes(:product)
                @product_with_preload = Transaction.preload(:product)
                @product_with_eager_load = Transaction.eager_load(:product)
                @product_with_strict_loading = Transaction.strict_loading(:product)
                

                product_sold = {}


                # @product_with_joins.each do |key, value|
                #     product_sold[key] = value
                # end

                @product_with_includes.each do |t|
                    # puts t.product.name
                    if product_sold[t.product.name].nil?
                        product_sold[t.product.name] = 1
                    else
                        product_sold[t.product.name] = product_sold[t.product.name] + 1 
                    end
                end

                # product = {
                #     "product_with_joins": @product_with_joins,
                #     "product_with_includes": @product_with_includes,
                #     "product_with_preload": @product_with_preload,
                #     "product_with_eager_load": @product_with_eager_load,
                #     "product_with_strict_loading": @product_with_strict_loading
                # }
                
                # All the queries are giving the same result.

                # render json: product_sold

                # it was not working 
                # @product_with_include_count = Transaction.includes(:product).group(:product_id).order('count(product_id) desc').count

                # product_sold_count_with_include = {}
                # @product_with_include_count.each do |key, value|
                #     puts key.inspect
                # end
                # render json: @product_with_include_count

                @joining_multiple_tables = Transaction.joins(:product, :customerinfo)
                json = {}
                @joining_multiple_tables.each do |t|
                    if json[t.product.name].nil?
                        json[t.product.name] = t.customerinfo.email
                    else
                        json[t.product.name] = json[t.product.name] + ", " + t.customerinfo.email
                    end
                end
                render json: json
            end

            def most_active_customer
                @most_active_customer = Transaction.preload(:customerinfo)
                json = {}
                @most_active_customer.each do |t|
                    if json[t.customerinfo.email].nil?
                        json[t.customerinfo.email] = 1
                    else
                        json[t.customerinfo.email] = json[t.customerinfo.email] + 1
                    end
                end
                render json: json.sort_by {|k,v| v}.reverse.to_h
            end

            def most_liked_product
                # there is a bug in this case, if two products have same name then it won't work.
                # we again loop one array then need to query name in it.
                # suppose if we use an external memory and store the name at end of current loop then the last values are override the previous values.
                @most_liked_product = Like.includes(likeable: :product).where(likeable_type: "Product")
                json = {}
                json_with_product_name = {}
                @most_liked_product.each do |t|
                    if json[t.likeable_id].nil?
                        json[t.likeable_id] = 1
                    else
                        json[t.likeable_id] = json[t.likeable_id] + 1
                    end
                end

                render json: json
            end

            def check_resource_owner
                if doorkeeper_token
                    @current_customerinfo ||= Customerinfo.find_by(id: doorkeeper_token.resource_owner_id)
                    if @current_customerinfo.nil?
                        render json: "Unauthorized access" , status: :unauthorized
                    end
                else
                    render json: "Unauthorized access." , status: :unauthorized
                end
            end

            def check_custom_api_resource_owner
                if doorkeeper_token
                    @current_customerinfo ||= Customerinfo.find_by(id: doorkeeper_token.resource_owner_id)
                    unless @current_customerinfo.nil?
                        render json: "Unauthorized access, You are not allowed to visit this API, Because this API is used for Business purpose." , status: :unauthorized
                    end
                else
                    render json: "Unauthorized access." , status: :unauthorized
                end
            end
                    
            def update
                @product = Product.find(params[:id])
                if @product.update(product_params)
                    render json: @product
                else
                    render json: @product.errors, status: :unprocessable_entity
                end
            end

            def show
                @product = Product.find(params[:id])
                render json: @product
            end

            def destroy
                @product = Product.find(params[:id])
                @product.destroy
                render json: "Product was successfully deleted."
            end

            def create
                @product = Product.new(product_params)
                if @product.save
                    render json: @product
                else
                    render json: @product.errors, status: :unprocessable_entity
                end
            end

            def set_product
                @product = Product.find(params[:id])
            end

            def record_not_found
                render json: { error: "Product not found or Invalid Product ID." }, status: :not_found
            end

            private
            
            def product_params
                params.require(:product).permit(:name, :description, :brand, :price, :category_id, :type_id, :total_stock_amount, :seller_id, :image)
            end  
        end
end