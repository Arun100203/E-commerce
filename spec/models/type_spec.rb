require 'rails_helper'


RSpec.describe Type, type: :model do
  
  context 'Checking category model' do
    let!(:type) { build(:type) }
    it 'with valid data' do
      expect(type).to be_valid
    end
  end

  context 'Checking category model' do
    let!(:type) { build(:type, typeinfo: nil) }
    it 'with invalid type' do
      expect(type).not_to be_valid
    end
  end

  context 'Checking category association' do
    it 'association with categories' do 
      expect(Type.reflect_on_association(:categories).macro).to eq(:has_and_belongs_to_many)
    end

    it 'association with products' do
      expect(Type.reflect_on_association(:product).macro).to eq(:has_many)
    end
  end
end

