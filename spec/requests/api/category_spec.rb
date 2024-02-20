require 'rails_helper'

RSpec.describe Category, type: :request do
    context '/categories' do
        let!(:category) { create(:category) }
        let!(:token) {{
            "grant_type": "password",
            "email": "hello@example.com",
            "password": "password",
            "client_id": "63h4FRw0Rbs69nI6Gqy2pq8KD7QBUoO9PB1xSCja3oY",
            "client_secret": "IwT4UZ_OzSc_Ijxt-gs23Nlc-ckFpFdCrtJBdVYhBrw"
        }}
        let!(:access_token) { "" }

        it 'GET will return all list of categories' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            get '/api/v1/categories', headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
        end

        it 'POST will create a new category' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            post '/api/v1/categories', params: { category: attributes_for(:category) }, headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body["category"]).to eq(category.to_json["category"])
        end

        it 'PUT will update a category' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            put "/api/v1/categories/#{category.id}", params: { category: attributes_for(:category) }, headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body["category"]).to eq(category.to_json["category"])
        end

        it 'DELETE will delete a product' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            delete "/api/v1/categories/#{category.id}", headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body).to eq('Category was successfully deleted.')
        end
    end
end