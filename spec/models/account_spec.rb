require 'rails_helper'


RSpec.describe Account, type: :model do
    
    context 'Checking account model' do
        let!(:account) { build(:account) }
        it 'with valid data' do
            expect(account).to be_valid
        end
    end

    context 'Checking account model' do
        let!(:account) { build(:account, account_no: nil) }

        it 'with invalid account_no' do
            expect(account).not_to be_valid
        end
        let!(:account) { build(:account, ifsc: nil) }

        it 'with invalid ifsc' do
            expect(account).not_to be_valid
        end
        let!(:account) { build(:account, bank_name: nil) }

        it 'with invalid bank_name' do
            expect(account).not_to be_valid
        end
        let!(:account) { build(:account, account_no: nil, ifsc: nil, bank_name: nil) }

        it 'with invalid account_no, ifsc, bank_name' do
            expect(account).not_to be_valid
        end
    end

    context 'Checking account association' do
        it 'belongs to customer' do
            expect(Account.reflect_on_association(:customerinfo).macro).to eq(:belongs_to)
        end
    end
end

