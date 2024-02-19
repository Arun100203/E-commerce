require 'rails_helper'

RSpec.describe Account, type: :request do
    context '/accounts' do
        let!(:account) { create(:account) }

        # it 'GET/ it will give all address' do
        #     get accounts_path
        #     expect(response).to have_http_status(200)
        # end

        # it 'POST/ it will create a new account' do
        #     post '/accounts', params: { account: attributes_for(:account) }
        #     expect(response).to redirect_to(accounts_path)
        #     expect(response).to have_http_status(302)
        #     expect(flash[:notice]).to eq('Account was successfully created.')
        # end

        # it 'PUT/ it will update a account' do
        #     account = create(:account, account_no: "987654321")
        #     put "/accounts/#{account.id}", params: { account: attributes_for(:account) }
        #     expect(response).to redirect_to(account_path(account.id))
        #     expect(response).to have_http_status(302)
        #     expect(flash[:notice]).to eq('Account was successfully updated.')
        # end

        it 'DELETE/ it will delete a account' do
            delete "/accounts/#{account.id}"
            expect(response).to redirect_to(accounts_path)
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to eq('Account was successfully deleted.')
        end
    end
end