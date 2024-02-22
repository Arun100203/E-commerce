require 'rails_helper'

RSpec.describe Comment, type: :request do
    context 'Checking comment controller' do
        let!(:product) { create(:product) }
        let!(:customerinfo) { build(:customerinfo) }
        let!(:comment) { create(:comment) }

        it 'get all the comments' do
            get "/products/#{product.id}"
            expect(response).to have_http_status(200)
            expect(response.body.to_s).to include(comment.body)
        end

        it 'without login redirect to login page' do
            post comments_path(product.id), params: { comment: attributes_for(:comment) }
            expect(response).to redirect_to(new_customerinfo_session_path)
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Please login to comment.')
        end

        it 'delete the comment' do
            allow_any_instance_of(CommentsController).to receive(:current_customerinfo).and_return(customerinfo)
            delete delete_comment_comment_path(comment.id), params: { comment: attributes_for(:comment) }
            expect(response).to redirect_to(product_path(product.id))
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Comment was successfully deleted.')
        end
    end
end