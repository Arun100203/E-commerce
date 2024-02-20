require 'rails_helper'

RSpec.describe Like, type: :model do
    context 'Checking like model' do
        let!(:like) { build(:like) }
        it 'with valid data' do
            expect(like).to be_valid
        end
    end

    context 'Checking like model' do
        let!(:like) { build(:like, customerinfo_id: nil) }
        it 'with invalid customerinfo' do
            expect(like).not_to be_valid
        end

        let!(:like) { build(:like, likeable_id: nil) }
        it 'with invalid product' do
            expect(like).not_to be_valid
        end

        let!(:like) { build(:like, customerinfo_id: nil, likeable_id: nil, likeable_type: nil) }
        it 'with invalid customerinfo and likeable type and id' do
            expect(like).not_to be_valid
        end
    end

    context 'Checking like association' do
        it 'Checking like association with customerinfo' do
            expect(Like.reflect_on_association(:customerinfo).macro).to eq(:belongs_to)
        end
    end
end