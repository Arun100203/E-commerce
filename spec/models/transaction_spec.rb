require 'rails_helper'


RSpec.describe Transaction, type: :model do
    
    context 'Checking transaction model' do
        let!(:transaction) { build(:transaction) }
        it 'with valid data' do
            expect(transaction).to be_valid
        end
    end

    context 'Checking transaction model' do
        let!(:transaction) { build(:transaction, customerinfo_id: nil) }
        it 'with invalid customerinfo' do
            expect(transaction).not_to be_valid
        end

        let!(:transaction) { build(:transaction, product_id: nil) }
        it 'with invalid product' do
            expect(transaction).not_to be_valid
        end

        let!(:transaction) { build(:transaction, seller_id: nil) }
        it 'with invalid seller' do
            expect(transaction).not_to be_valid
        end

        let!(:transaction) { build(:transaction, account_id: nil) }
        it 'with invalid account' do
            expect(transaction).not_to be_valid
        end

        let!(:transaction) { build(:transaction, amount: nil) }
        it 'with invalid amount' do
            expect(transaction).not_to be_valid
        end

        let!(:transaction) { build(:transaction, qty: nil) }
        it 'with invalid qty' do
            expect(transaction).not_to be_valid
        end

        let!(:transaction) { build(:transaction, status: nil) }
        it 'with invalid status' do
            expect(transaction).not_to be_valid
        end

        let!(:transaction) { build(:transaction, customerinfo_id: nil, product_id: nil, seller_id: nil, account_id: nil, amount: nil, qty: nil, status: nil) }
        it 'with invalid customerinfo, product, seller, account, amount, qty, status' do
            expect(transaction).not_to be_valid
        end
    end

    context 'Checking transaction association' do
        it 'association with customer' do
            expect(Transaction.reflect_on_association(:customerinfo).macro).to eq(:belongs_to)
        end

        it 'association with product' do
            expect(Transaction.reflect_on_association(:product).macro).to eq(:belongs_to)
        end
    end
end

