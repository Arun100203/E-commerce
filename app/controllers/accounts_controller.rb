class AccountsController < ApplicationController

    before_action :set_account, only: [:edit, :update, :show, :destroy]
    rescue_from Exception, with: :exception_handler

    def index
        @accounts = Account.all
    end

    def show
    end

    def new
        @account = Account.new
    end

    def create
        @account = Account.new(account_params)
        if @account.save
            redirect_to accounts_path, notice: 'Account was successfully created.'
        else
            redirect_to accounts_path, notice: 'Error Occurred during account creation.'
        end
    end

    def edit
    end 

    def update
        if @account.update(account_params)
            redirect_to accounts_path, notice: 'Account was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        if @account.destroy
            redirect_to accounts_path, notice: "Account was successfully deleted."
        else
            redirect_to accounts_path, notice: "Error deleting account."
        end
    end

    def set_account
        @account = Account.find(params[:id]) 
    end

    def exception_handler(exception)
        if exception.is_a?(ActiveRecord::RecordNotFound)
            render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
        else
            render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false
        end
    end

    private

    def account_params
        params.require(:account).permit(:account_no, :ifsc, :bank_name, :customerinfo_id)
    end

end
