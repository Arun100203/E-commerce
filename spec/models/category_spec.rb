require 'rails_helper'


RSpec.describe Category, type: :model do

    context 'Checking category model' do
      let!(:category) { build(:category) }
      it 'with valid data' do
          expect(category).to be_valid
      end
    end

    context 'Checking category model' do
      let!(:category) { build(:category, category: nil) }
      it 'with invalid category' do
          expect(category).not_to be_valid
      end
    end

    context 'Checking category association' do
      it 'has many products' do
          expect(Category.reflect_on_association(:products).macro).to eq(:has_many)
      end

      it 'has and belongs to many types' do 
          expect(Category.reflect_on_association(:types).macro).to eq(:has_and_belongs_to_many)
      end
    end
end

