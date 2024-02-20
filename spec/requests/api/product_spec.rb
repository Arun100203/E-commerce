require 'rails_helper'

RSpec.describe Product, type: :request do
    context '/products' do
        let!(:product) { create(:product) }
        let!(:token) {{
            "grant_type": "password",
            "email": "hello@example.com",
            "password": "password",
            "client_id": "63h4FRw0Rbs69nI6Gqy2pq8KD7QBUoO9PB1xSCja3oY",
            "client_secret": "IwT4UZ_OzSc_Ijxt-gs23Nlc-ckFpFdCrtJBdVYhBrw"
        }}
        let!(:access_token) { "" }

        it 'GET will return all list of products' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            get '/api/v1/products', headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
        end

        it 'POST will create a new product' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            post '/api/v1/products', params: { product: attributes_for(:product) }, headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body["name"]).to eq(product.to_json["name"])
            expect(response.body["description"]).to eq(product.to_json["description"])
            expect(response.body["price"]).to eq(product.to_json["price"])
            expect(response.body["total_stock_amount"]).to eq(product.to_json["total_stock_amount"])
            expect(response.body["seller_id"]).to eq(product.to_json["seller_id"])
            expect(response.body["category_id"]).to eq(product.to_json["category_id"])
            expect(response.body["type_id"]).to eq(product.to_json["type_id"])
        end

        it 'PUT will update a product' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            put "/api/v1/products/#{product.id}", params: { product: attributes_for(:product) }, headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body["name"]).to eq(product.to_json["name"])
            expect(response.body["description"]).to eq(product.to_json["description"])
            expect(response.body["price"]).to eq(product.to_json["price"])
            expect(response.body["total_stock_amount"]).to eq(product.to_json["total_stock_amount"])
            expect(response.body["seller_id"]).to eq(product.to_json["seller_id"])
            expect(response.body["category_id"]).to eq(product.to_json["category_id"])
            expect(response.body["type_id"]).to eq(product.to_json["type_id"])
        end

        it 'DELETE will delete a product' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            delete "/api/v1/products/#{product.id}", headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body).to eq('Product was successfully deleted.')
        end

        it 'test the custom api controller' do
            token = {
                "grant_type": "client_credentials",
                "client_id": "63h4FRw0Rbs69nI6Gqy2pq8KD7QBUoO9PB1xSCja3oY",
                "client_secret": "IwT4UZ_OzSc_Ijxt-gs23Nlc-ckFpFdCrtJBdVYhBrw"
            }
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            get '/api/v1/products/product_sold_count', headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
        end
    end
end