module Api::V1
    class CartsController < BaseController
        
        # for API calls
        before_action :set_cart, only: [ :update]
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
        before_action :check_resource_owner, only: [:index, :show, :update, :destroy, :create, :set_cart]

        def index
            render json: Cart.all
        end

        def update
            @cart = Cart.find(params[:id])
            if @cart.update(cart_params)
                render json: @cart
            else
                render json: @cart.errors, status: :unprocessable_entity
            end
        end

        def show
            @cart = Cart.find(params[:id])
            render json: @cart
        end

        def destroy
            @cart = Cart.find(params[:id])
            @cart.destroy
            render json: "Cart item was successfully deleted."
        end

        def create
            @cart = Cart.new(cart_params)
            if @cart.save
                render json: @cart
            else
                render json: @cart.errors, status: :unprocessable_entity
            end
        end

        def set_cart
            @cart = Cart.find(params[:id])
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

        def record_not_found
            render json: { error: "Cart item not found or Invalid Cart item ID." }, status: :not_found
        end

        private
        
        def cart_params
            params.require(:cart).permit(:product_id, :customerinfo_id)
        end  
    end
end