require 'rails_helper'

RSpec.describe "Customerinfos", type: :system do
    describe 'Customerinfo sign up' do
        let(:customer) { create(:customerinfo) }

        it 'Checking Customerinfo with empty values' do
            visit '/customerinfos/sign_up'
            click_button 'Sign up'

            expect(page).to have_content("Email can't be blank")
            expect(page).to have_content("Password can't be blank")
            expect(page).to have_content("Name can't be blank")
            expect(page).to have_content("Phone number can't be blank")
            expect(page).to have_content("Phone number is too short (minimum is 8 characters)")
        end

        it 'Checking Customerinfo with valid form' do
            visit '/customerinfos/sign_up'
            fill_in 'customerinfo_email', with: "email1234@gmail.com"
            fill_in 'customerinfo_password', with: customer.password
            fill_in 'customerinfo_password_confirmation', with: customer.password
            fill_in 'customerinfo_name', with: customer.name
            fill_in 'customerinfo_phone_number', with: customer.phone_number
            click_button 'Sign up'

            expect(page).to have_content("Welcome Test!")
        end
    end

    describe 'Customerinfo sign up' do
        let(:customer) { create(:customerinfo) }

        before(:each) do
            visit '/customerinfos/sign_in'
            fill_in 'customerinfo_email', with: customer.email
            fill_in 'customerinfo_password', with: customer.password
            click_button 'Log in'
        end

        it 'Checking Customerinfo sign out' do
            click_button 'Sign-out'
            expect(page).to have_content("Signed out successfully.")
        end 

        it 'Checking Customerinfo login page' do
            expect(page).to have_content("Signed in successfully.")
        end

        it 'Checking Customerinfo edit page' do
            click_link 'Edit-profile'
            fill_in 'customerinfo_name', with: "changed name"
            fill_in 'customerinfo_phone_number', with: "1234567890"
            fill_in 'customerinfo_current_password', with: customer.password
            fill_in 'customerinfo_email', with: customer.email
            click_button 'Update'
            expect(page).to have_content("Your account has been updated successfully.")
        end

        it 'Checking Customerinfo delete page' do
            click_link 'Edit-profile'
            click_button 'Cancel my account'
            page.driver.browser.switch_to.alert.accept
            expect(page).to have_content("Bye! Your account has been successfully cancelled. We hope to see you again soon.")
        end
    end 
end
