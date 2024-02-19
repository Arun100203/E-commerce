class CommentsController < ApplicationController
    before_action :set_comment, only: [:edit, :update, :like, :unlike, :delete_comment]
    rescue_from Exception, with: :exception_handler

    def new
        @comment = Comment.new
    end
    
    def create
        if current_customerinfo.nil?
            redirect_to new_customerinfo_session_path, notice: "Please login to comment."
            return
        end

        @comment = Comment.new(comment_params)
        
        if @comment.save
            redirect_to product_path(comment_params[:product_id]), notice: 'Comment was successfully created.'
        else
            redirect_to product_path(comment_params[:product_id]), notice: "Comments Cannot be blank"
        end
    end

    def edit
    end

    def update
        if @comment.update(comment_params)
            redirect_to product_path(@comment.product_id), notice: 'Comment was successfully updated.'
        else
            redirect_to product_path(@comment.product_id), notice: 'Error occurred during update.'
        end
    end

    def like
        unless customerinfo_signed_in?
            redirect_to new_customerinfo_session_path, notice: "Please login to like the comment."
            return
        end

        like = Like.new(likeable: @comment, customerinfo_id: current_customerinfo.id)
        if like.save
            redirect_to product_path(@comment.product_id), notice: "You liked this comment."
        else
            redirect_to product_path(@comment.product_id), notice: "Failed to like the comment."
        end
    end

    def unlike
        unless customerinfo_signed_in?
            redirect_to new_customerinfo_session_path, notice: "Please login to unlike the comment."
            return
        end

        Like.find_by(likeable: @comment, customerinfo_id: current_customerinfo.id).destroy
        redirect_to product_path(@comment.product_id), notice: "You unliked this comment."
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def delete_comment
        unless customerinfo_signed_in?
            redirect_to new_customerinfo_session_path, notice: "Please login to delete the comment."
        end

        if @comment.destroy
            redirect_to product_path(@comment.product_id), notice: "Comment was successfully deleted."
        else
            redirect_to product_path(@comment.product_id), notice: "Error deleting comment."
        end
    end

    def exception_handler(exception)
        if exception.is_a?(ActiveRecord::RecordNotFound)
            render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
        else
            render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false
        end
    end
    
    private

    def comment_params
        params.require(:comment).permit(:product_id, :customerinfo_id, :body)
    end
end
