module Api::V1
        class ProductsController < BaseController
            
            # for API calls
            before_action  :set_product, only: [ :update]
            before_action :check_resource_owner, only: [:create, :update, :destroy, :index, :show, :set_product]
            before_action :check_custom_api_resource_owner, only: [:product_sold_count]
            rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

            def index
                render json: Product.all
            end

            # Custom API controller 
            def product_sold_count
                @product = Product.joins(:transactions).group(:id).order('count(transactions.product_id) desc').count
                product_sold = {}
                @product.each do |key, value|
                    product_sold[Product.find(key).name] = value
                end

                render json: product_sold
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