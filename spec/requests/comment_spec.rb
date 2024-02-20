require 'rails_helper'

RSpec.describe Comment, type: :request do
    context 'Checking comment controller' do
        let!(:product) { create(:product) }
        let!(:comment) { create(:comment) }
        it 'get all the comments' do
            get '/products'
            expect(response).to have_http_status(200)
        end

        # it 'without login redirect to login page' do
        #     post "/products/#{product.id}/comments", params: { comment: attributes_for(:comment) }
        #     expect(response).to redirect_to(new_customerinfo_session_path)
        #     expect(response).to have_http_status(302)
        #     expect(flash[:notice]).to eq('Please login to comment the product.')
        # end
    end
end