require 'rails_helper'

RSpec.describe Cart, type: :model do
    
    context 'Checking cart model' do
        let!(:cart) { build(:cart) }
        it 'with valid data' do
            expect(cart).to be_valid
        end
    end

    context 'Checking cart model' do
        let!(:cart) { build(:cart, customerinfo_id: nil) }
        it 'with invalid customerinfo' do
            expect(cart).not_to be_valid
        end

        let!(:cart) { build(:cart, product_id: nil) }
        it 'with invalid product' do
            expect(cart).not_to be_valid
        end

        let!(:cart) { build(:cart, customerinfo_id: nil, product_id: nil) }
        it 'with invalid customerinfo and product' do
            expect(cart).not_to be_valid
        end
    end

    context 'Checking cart model' do
        it 'Checking cart association with customerinfo' do
            expect(Cart.reflect_on_association(:customerinfo).macro).to eq(:belongs_to)
        end

        it 'Checking cart association with product' do
            expect(Cart.reflect_on_association(:products).macro).to eq(:has_many)
        end
    end
end

