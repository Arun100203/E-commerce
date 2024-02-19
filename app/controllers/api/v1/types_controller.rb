module Api::V1
        class TypesController < BaseController
            
            # for API calls
            before_action :set_type, only: [ :update]
            before_action :check_resource_owner, only: [:create, :update, :destroy]
            rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

            def index
                render json: Type.all
            end

            def update
                @type = Type.find(params[:id])
                if @type.update(type_params)
                    render json: @type
                else
                    render json: @type.errors, status: :unprocessable_entity
                end
            end

            def show
                @type = Type.find(params[:id])
                render json: @type
            end

            def destroy
                @type = Type.find(params[:id])
                Type.delete(params[:id])
                render json: "Type was successfully deleted."
            end

            def create
                @type = Type.new(type_params)
                if @type.save
                    render json: @type
                else
                    render json: @type.errors, status: :unprocessable_entity
                end
            end

            def record_not_found
                render json: { error: "Type not found or Invalid Type ID." }, status: :not_found
            end

            def set_type
                @type = Type.find(params[:id])
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

            private
            
            def type_params
                params.require(:type).permit(:typeinfo)
            end  
        end
end