require 'rails_helper'

RSpec.describe "Products", type: :system do


    describe 'Product CRUD operations' do
        let!(:customer) { build(:customerinfo) }
        let!(:product) { build(:product) }


        before(:each) do
            visit '/customerinfos/sign_in'
            fill_in 'customerinfo_email', with: customer.email
            fill_in 'customerinfo_password', with: customer.password
            click_button 'Log in'
        end 

        it 'Checking Product with valid details' do
            click_link 'Sell Product'
            click_button 'Add new Product' 
            fill_in 'product_name', with: product.name
            fill_in 'product_description', with: product.description
            fill_in 'product_price', with: product.price
            fill_in 'product_total_stock_amount', with: product.total_stock_amount

            click_button 'Create Product'
            expect(page).to have_content("Product was successfully created.")
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