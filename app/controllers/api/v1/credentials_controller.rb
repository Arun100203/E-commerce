module Api::V1
    class CredentialsController < BaseController
        before_action :doorkeeper_authorize!
        
        respond_to :json

        def me
            render json: current_resource_owner
        end

        private

        def current_resource_owner
            if doorkeeper_token
                Customerinfo.find(doorkeeper_token.resource_owner_id)
            end
        end
    end
end