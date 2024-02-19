require 'rails_helper'


RSpec.describe Product, type: :model do
    context 'Checking product model' do
        let!(:product) { build(:product) }
        it 'with valid data' do
            expect(product).to be_valid
        end
    end

    context 'Checking product model' do
        let!(:product) { build(:product, name: nil) }
        it 'with invalid name' do
            expect(product).not_to be_valid
        end

        let!(:product) { build(:product, description: nil) }
        it 'with invalid description' do
            expect(product).not_to be_valid
        end

        let!(:product) { build(:product, price: nil) }
        it 'with invalid price' do
            expect(product).not_to be_valid
        end

        let!(:product) { build(:product, total_stock_amount: nil) }
        it 'with invalid total_stock_amount' do
            expect(product).not_to be_valid
        end

        let!(:product) { build(:product, seller_id: nil) }
        it 'with invalid seller_id' do
            expect(product).not_to be_valid
        end

        let!(:product) { build(:product, name: nil, description: nil, price: nil, total_stock_amount: nil, seller_id: nil) }
        it 'with invalid name, description, price, total_stock_amount, seller_id' do
            expect(product).not_to be_valid
        end
    end

    context 'Checking product association' do
        it 'Checking product association with likes' do
            expect(Product.reflect_on_association(:likes).macro).to eq(:has_many)
        end

        it 'Checking product association with categories' do
            expect(Product.reflect_on_association(:category).macro).to eq(:belongs_to)
        end

        it 'Checking product association with types' do
            expect(Product.reflect_on_association(:type).macro).to eq(:belongs_to)
        end

        it 'Checking product association with comments' do
            expect(Product.reflect_on_association(:comments).macro).to eq(:has_many)
        end

        it 'Checking product association with transactions' do
            expect(Product.reflect_on_association(:transactions).macro).to eq(:has_many)
        end
    end
end

