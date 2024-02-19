require 'rails_helper'

RSpec.describe Address, type: :request do
    describe 'GET /addresses' do
        let!(:address) { create(:address) }
        # it 'returns all addresses' do
        #     get '/profiles'
        #     expect(response).to have_http_status(500)
        # end

        # it 'POST/ it will create a new address' do
        #     post '/profiles', params: { address: attributes_for(:address) }
        #     expect(flash[:notice]).to eq(nil)
        # end

        it 'PUT/ it will update a address' do
            address = create(:address, street: "changed address")
            put "/profiles/#{address.id}", params: { address: attributes_for(:address) }
            expect(response).to redirect_to(profiles_path)
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Address was successfully updated.')
        end

        it 'DELETE/ it will delete a address' do
            delete "/profiles/#{address.id}"
            expect(response).to redirect_to(profiles_path)
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Address was successfully deleted.')
        end
    end
end