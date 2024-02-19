module Api::V1
    class TransactionsController < BaseController
        
        # for API calls
        before_action :set_transaction, only: [ :update]
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
        before_action :check_resource_owner, only: [:index, :show, :update, :destroy, :create, :set_transaction]

        def index
            render json: Transaction.all
        end

        def update
            @transaction = Transaction.find(params[:id])
            if @transaction.update(transaction_params)
                render json: @transaction
            else
                render json: @transaction.errors, status: :unprocessable_entity
            end
        end

        def show
            @transaction = Transaction.find(params[:id])
            render json: @transaction
        end

        def destroy
            @transaction = Transaction.find(params[:id])
            @transaction.destroy
            render json: "Transaction was successfully deleted."
        end

        def create
            @transaction = Transaction.new(transaction_params)
            if @transaction.save
                render json: @transaction
            else
                render json: @transaction.errors, status: :unprocessable_entity
            end
        end

        def record_not_found    
            render json: { error: "Transaction not found or Invalid Transaction ID." }, status: :not_found
        end

        def set_transaction
            @transaction = Transaction.find(params[:id])
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
        
        def transaction_params
            params.require(:transaction).permit(:customerinfo_id, :product_id, :seller_id, :account_id, :qty, :amount, :status, :location, :date)
        end  
    end
end