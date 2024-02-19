require 'rails_helper'


RSpec.describe Address, type: :model do
    
    context 'Checking address model' do
        let!(:address) { build(:address) }

        it 'with valid data' do
        expect(address).to be_valid
        end
    end

    context 'Checking address model' do
        let!(:address) { build(:address, door_no: nil) }
        it 'with invalid door_no' do
            expect(address).not_to be_valid
        end

        let!(:address) { build(:address, street: nil) }
        it 'with invalid street' do
            expect(address).not_to be_valid
        end

        let!(:address) { build(:address, state: nil) }
        it 'with invalid state' do
            expect(address).not_to be_valid
        end

        let!(:address) { build(:address, country: nil) }
        it 'with invalid country' do
            expect(address).not_to be_valid
        end

        let!(:address) { build(:address, pincode: nil) }
        it 'with invalid pincode' do
            expect(address).not_to be_valid
        end

        let!(:address) { build(:address, door_no: nil, street: nil, state: nil, country: nil, pincode: nil) }
        it 'with all invalid data' do
            expect(address).not_to be_valid
        end
    end

    context 'Checking address associations' do
        it 'belongs to customerinfo' do
            expect(Address.reflect_on_association(:customerinfo).macro).to eq(:belongs_to)
        end
    end
end

