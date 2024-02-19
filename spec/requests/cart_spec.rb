require 'rails_helper'

RSpec.describe Cart, type: :request do
    context 'GET /carts' do
        let!(:cart) { build(:cart) }

        it 'should get all carts' do
            get '/carts'
            expect(response).to have_http_status(200)
        end
    end
end