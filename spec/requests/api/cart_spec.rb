require 'rails_helper'

RSpec.describe Cart, type: :request do
    context '/carts' do
        let!(:cart) { create(:cart) }
        let!(:token) {{
            "grant_type": "password",
            "email": "hello@example.com",
            "password": "password",
            "client_id": "63h4FRw0Rbs69nI6Gqy2pq8KD7QBUoO9PB1xSCja3oY",
            "client_secret": "IwT4UZ_OzSc_Ijxt-gs23Nlc-ckFpFdCrtJBdVYhBrw"
        }}
        let!(:access_token) { "" }

        it 'GET will return all list of carts' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            get '/api/v1/carts', headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
        end

        it 'POST will create a new cart' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            post '/api/v1/carts', params: { cart: attributes_for(:cart) }, headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body["customerinfo_id"]).to eq(cart.to_json["customerinfo_id"])
            expect(response.body["product_id"]).to eq(cart.to_json["product_id"])
        end

        it 'PUT will update a cart' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            put "/api/v1/carts/#{cart.id}", params: { cart: attributes_for(:cart) }, headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body["customerinfo_id"]).to eq(cart.to_json["customerinfo_id"])
            expect(response.body["product_id"]).to eq(cart.to_json["product_id"])
        end

        it 'DELETE will delete a product' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            delete "/api/v1/carts/#{cart.id}", headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body).to eq('Cart item was successfully deleted.')
        end
    end
end