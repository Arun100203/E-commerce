require 'rails_helper'

RSpec.describe "Products", type: :system do


    describe 'Product CRUD operations' do
        let!(:customer) { create(:customerinfo) }
        let!(:product) { create(:product) }


        before(:each) do
            visit '/customerinfos/sign_in'
            fill_in 'customerinfo_email', with: customer.email
            fill_in 'customerinfo_password', with: customer.password
            click_button 'Log in'
        end 

        it 'Checking Product with Invalid details' do
            click_link 'Sell Product'
            click_button 'Add new Product' 

            click_button 'Create Product'
            expect(page).to have_content("Category must exist")
            expect(page).to have_content("Type must exist")
            expect(page).to have_content("Name can't be blank")
            expect(page).to have_content("Description can't be blank")
            expect(page).to have_content("Price can't be blank")
        end

        # it 'Checking Edit products' do 
        #     visit products_path(product.id)
        #     click_button 'Edit product'
        #     fill_in 'product_name', with: 'new name'
        #     click_button 'Update Product'

        #     expect(page).to have_content("Product was successfully updated.")
        # end

        # it 'Checking Delete products' do
        #     visit products_path(product.id)
        #     click_button 'Delete product'

        #     expect(page).to have_content("Product was successfully deleted.")
        # end
    end
end