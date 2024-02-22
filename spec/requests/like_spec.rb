require 'rails_helper'

RSpec.describe Like, type: :request do
    context 'likes for products' do
        let!(:product) { create(:product) }
        let!(:customerinfo) { create(:customerinfo) }
        let!(:like) { create(:like, likeable: product, customerinfo_id: customerinfo.id) }
        

        it 'show likes for products' do
            get product_path(product.id)
            expect(response).to have_http_status(200)
            expect(response.body.to_s).to include('Like (1)')
        end

        it 'with login delete the like for product' do
            # we are stubbing that it should return customerinfo
            allow_any_instance_of(LikesController).to receive(:current_customerinfo).and_return(customerinfo)
            delete like_path(product.id), params: { like: { likeable: product, customerinfo_id: customerinfo.id } }
            expect(response).to redirect_to(product_path(product.id))
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Product unliked!')
        end

        it 'without login redirect to login page' do
            delete like_path(product.id), params: { like: { likeable: product, customerinfo_id: customerinfo.id } }
            expect(response).to redirect_to(new_customerinfo_session_path)
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Please login to unlike the product.')
        end
    end
    context 'likes for comments' do
        let!(:product) { create(:product) }
        let!(:customerinfo) { create(:customerinfo) }
        let!(:comment) { create(:comment, product_id: product.id, customerinfo_id: customerinfo.id) }
        let!(:like) { create(:like, likeable: comment, customerinfo_id: customerinfo.id) }
        
        it 'show likes for comments' do
            get product_path(product.id)
            expect(response).to have_http_status(200)
            expect(response.body.to_s).to include('Like (1)')
        end

        it 'with login delete the like for comment' do
            # stubbing that it should return customerinfo
            allow_any_instance_of(CommentsController).to receive(:current_customerinfo).and_return(customerinfo)
            delete unlike_comment_path(comment.id), params: { like: { likeable: comment, customerinfo_id: customerinfo.id } }
            expect(response).to redirect_to(product_path(product.id))
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('You unliked this comment.')
        end

        it 'without login redirect to login page' do
            delete unlike_comment_path(comment.id), params: { like: { likeable: comment, customerinfo_id: customerinfo.id } }
            expect(response).to redirect_to(new_customerinfo_session_path)
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Please login to unlike the comment.')
        end
    end
end