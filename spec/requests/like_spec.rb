require 'rails_helper'

RSpec.describe Like, type: :request do
    context 'product shows like' do
        let!(:product) { create(:product) }
        let!(:like) { create(:like, likeable: product) }
        it 'show likes for products' do
            get product_path(product.id)
            expect(response).to have_http_status(200)
            expect(response.body.to_s).to include('Like (1)')
        end

        it 'without login redirect to login page' do
            delete like_path(product.id)
            expect(response).to redirect_to(new_customerinfo_session_path)
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Please login to unlike the product.')
        end
    end
end