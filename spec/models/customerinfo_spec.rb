require 'rails_helper'


RSpec.describe Customerinfo, type: :model do
 
  let(:customer1) { create(:customerinfo, email:"arunl.a@gmail.com", name:"Test", phone_number:1234567890, password:"123456")}
  let(:customer) { build(:customerinfo, email:"email@gmail.com") }
  
  context 'Checking Validations' do

    it 'Checking Customers with empty values' do
      customer = build(:customerinfo, email: nil, name: nil, phone_number: nil, password: nil)
      expect(customer).not_to be_valid
    end

    it 'Checking Customers with all fields correctly' do
      expect(customer).to be_valid
    end
  end

  context 'Checking Callbacks' do
    let(:mail) { CustomerinfoMailer.welcome_email(customer1) }

    it 'Checking Welcome Email Headers' do
      expect(mail.from).to eq(['arunarunarun7354@gmail.com'])
      expect(mail.to).to eq([customer1.email])
      expect(mail.subject).to match("Welcome to Online Shopping!!!...")
    end

    it 'Checking Welcome Email Body' do
      expect(mail.body.encoded).not_to eq(nil)
    end
  end

  context 'Checking Methods' do

    it 'Checking likes method with wrong object' do
      expect(customer1.likes?(customer1)).to eq(false)
    end

    it 'Checking likes method with correct object' do
      like = Like.create!(likeable_id: 1, likeable_type: "Product", customerinfo_id: customer1.id)
      expect(customer1.likes?(Product.find(1))).to eq(true)
    end

    it 'Checking authenticate method' do
      expect(Customerinfo.authenticate(customer1.email, "123456")).to eq(customer1)
    end
  end

end

