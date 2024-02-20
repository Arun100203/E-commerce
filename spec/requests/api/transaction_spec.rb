require 'rails_helper'

RSpec.describe Transaction, type: :request do
    context 'Test transactions API' do
        let!(:transaction) { create(:transaction) }
        let!(:token) {{
            "grant_type": "password",
            "email": "hello@example.com",
            "password": "password",
            "client_id": "63h4FRw0Rbs69nI6Gqy2pq8KD7QBUoO9PB1xSCja3oY",
            "client_secret": "IwT4UZ_OzSc_Ijxt-gs23Nlc-ckFpFdCrtJBdVYhBrw"
        }}
        let!(:access_token) { "" }

        it 'should get all transactions' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            get '/api/v1/transactions', headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
        end

        it 'should create a new transactions' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            post '/api/v1/transactions', params: { transaction: attributes_for(:transaction) }, headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(422)
            expect(response.body["customerinfo_id"]).to eq(transaction.to_json["customerinfo_id"])
            expect(response.body["product_id"]).to eq(transaction.to_json["product_id"])
        end

        it 'should update an transaction' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            put "/api/v1/transactions/#{transaction.id}", params: { transaction: attributes_for(:transaction) }, headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
            expect(response.body["customerinfo_id"]).to eq(transaction.to_json["customerinfo_id"])
            expect(response.body["product_id"]).to eq(transaction.to_json["product_id"])
            expect(response.body["qty"]).to eq(transaction.to_json["qty"])
            expect(response.body["amount"]).to eq(transaction.to_json["amount"])
            expect(response.body["status"]).to eq(transaction.to_json["status"])
            expect(response.body["location"]).to eq(transaction.to_json["location"])
            expect(response.body["account_id"]).to eq(transaction.to_json["account_id"])
        end

        it 'should delete an transaction' do
            post 'http://127.0.0.1:3000/oauth/token', params: token
            access_token = JSON.parse(response.body)["access_token"]
            delete "/api/v1/transactions/#{transaction.id}", headers: { "Authorization": "Bearer #{access_token}" }
            expect(response).to have_http_status(200)
        end
    end
end