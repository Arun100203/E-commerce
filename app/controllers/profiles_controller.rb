class ProfilesController < ApplicationController

    before_action :set_address, only: [:show, :edit, :update, :destroy]
    rescue_from Exception, with: :exception_handler

    def new
        @address = Address.new
    end
    
    def create
        address_params[:customerinfo_id] = current_customerinfo.id
        @address = Address.new(address_params)

        if @address.save
            redirect_to "/profiles", notice: 'Address was successfully created.'
        else
            redirect_to "/profiles", notice: "Error Occurred during address creation."
        end
    end

    def show
    end

    def index
        @addresses = Address.all
    end

    def edit
    end

    def update
        if @address.update(address_params)
            redirect_to profiles_path, notice: 'Address was successfully updated.'
        else
            redirect_to profiles_path, notice: 'Error updating address.'
        end
    end

    def destroy
        if @address.destroy
            redirect_to profiles_path, notice: "Address was successfully deleted."
        else
            redirect_to profiles_path, notice: "Error deleting address."
        end
    end
    
    def set_address
        @address = Address.find(params[:id])
    end

    def exception_handler(exception)
        if exception.is_a?(ActiveRecord::RecordNotFound)
            render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
        else
            render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false
        end
    end

    private

    def address_params
    params.require(:address).permit(:address_id, :door_no, :street, :state, :country, :pincode, :customerinfo_id)
    end
end
