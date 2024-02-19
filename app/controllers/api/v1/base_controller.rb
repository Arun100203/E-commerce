module Api::V1
    class BaseController < ApplicationController

        skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

        before_action :doorkeeper_authorize!

        private

        def current_customerinfo
            if doorkeeper_token
                @current_customerinfo ||= Customerinfo.find(doorkeeper_token.resource_owner_id)
            else
                @current_customerinfo = nil
            end
        end

    end
end