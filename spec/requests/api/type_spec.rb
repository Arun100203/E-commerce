require 'rails_helper'

RSpec.describe Type, type: :request do
    context 'Test types API' do
        let!(:type) { create(:type) }
        let!(:token) {{
            "grant_type": "password",
            "email": "hello@example.com",
            "password": "password",
            "client_id": "J7dWYDkOS_lots4BBHl6m_kcSO3nUnfj9BQg8yjedeE",
            "client_secret": "uD4UGfTmmJM14cRRUUIVajA4Ic53R4rE1b2UcC1sUv0"
        }}
        let!(:access_token) { "" }

        it 'should get all types' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            get '/api/v1/types', headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
        end

        it 'should create a new type' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            post '/api/v1/types', params: { type: attributes_for(:type) }, headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body["typeinfo"]).to eq(type.to_json["typeinfo"])
        end

        it 'should update an type' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            put "/api/v1/types/#{type.id}", params: { type: attributes_for(:type) }, headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body["typeinfo"]).to eq(type.to_json["typeinfo"])
        end

        it 'should delete an type' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            delete "/api/v1/types/#{type.id}", headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
        end
    end
end