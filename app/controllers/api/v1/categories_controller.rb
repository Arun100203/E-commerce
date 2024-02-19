module Api::V1 
    class CategoriesController < BaseController
            
            # for API calls
            before_action :set_category, only: [ :update]
            rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
            before_action :check_resource_owner, only: [:create, :update, :destroy]
    
            def index
                render json: Category.all
            end
    
            def update
                @category = Category.find(params[:id])
                if @category.update(category_params)
                    render json: @category
                else
                    render json: @category.errors, status: :unprocessable_entity
                end
            end
    
            def show
                @category = Category.find(params[:id])
                render json: @category
            end
    
            def destroy
                @category = Category.find(params[:id])
                Category.delete(params[:id])
                render json: 'Category was successfully deleted.'
            end
    
            def create
                @category = Category.new(category_params)
                if @category.save
                    render json: @category
                else
                    render json: @category.errors, status: :unprocessable_entity
                end
            end
    
            def record_not_found
                render json: { error: "Category not found or Invalid Category ID." }, status: :not_found
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

            def set_category
                @category = Category.find(params[:id])
            end
    
            private
            
            def category_params
                params.require(:category).permit(:category)
            end  
        end
    end
