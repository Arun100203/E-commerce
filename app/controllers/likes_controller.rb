class LikesController < ApplicationController
    before_action :set_product, only: [:create, :destroy]
    rescue_from Exception, with: :exception_handler
    

    def new
        @like = Like.new
    end

    def create
        if current_customerinfo.nil?
            redirect_to new_customerinfo_session_path, notice: "Please login to like the product."
            return
        end
        
        like = Like.new(likeable: @product, customerinfo_id: current_customerinfo.id)

        if like.save
          redirect_to product_path(@product.id), notice: "You liked this product."
        else
          redirect_to product_path(@product.id), notice: "Failed to like the product."
        end
    end

    def destroy
        if current_customerinfo.nil?
            redirect_to new_customerinfo_session_path, notice: "Please login to unlike the product."
            return
        end

        like = Like.find_by(likeable: @product, customerinfo_id: current_customerinfo)
        Like.delete(like.id)
        redirect_to product_path(@product.id), notice: 'Product unliked!'
    end

    def set_product
        @product = Product.find(params[:id])
    end

    def exception_handler(exception)
        if exception.is_a?(ActiveRecord::RecordNotFound)
            render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
        else
            render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false
        end
    end

    private

    def like_params
        params.require(:like).permit(:likeable, :customerinfo_id)
    end
end
