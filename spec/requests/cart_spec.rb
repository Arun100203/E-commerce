require 'rails_helper'

RSpec.describe Cart, type: :request do
    context 'GET /carts' do
        let!(:cart) { build(:cart) }

        it 'should get all carts' do
            get '/carts'
            expect(response).to have_http_status(302)
        end

        it 'should create a new cart' do
            post '/carts', params: { cart: attributes_for(:cart) }
            expect(response).to redirect_to(carts_path)
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Successfully Purchased the product.')
        end
    end
end