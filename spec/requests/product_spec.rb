require 'rails_helper'

RSpec.describe Product, type: :request do
    context '/products' do
        let!(:product) { create(:product) }
        it 'GET will return all list of products' do
            get '/products'
            expect(response).to have_http_status(200)
        end

        it 'POST will create a new product' do
            post '/products', params: { product: attributes_for(:product) }
            expect(response).to redirect_to(product_path(product.id+1))
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Product was successfully created.')
        end

        it 'PUT will update a product' do
            product = create(:product, name:"changed product name")
            put "/products/#{product.id}", params: { product: attributes_for(:product) }
            expect(response).to redirect_to(product_path(product.id))
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Product was successfully updated.')
        end

        it 'DELETE will delete a product' do
            delete "/products/#{product.id}"
            expect(response).to redirect_to(root_path)
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Product was successfully deleted.')
        end
    end
end