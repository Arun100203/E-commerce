class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    rescue_from Exception, with: :exception_handler


    def exception_handler(exception)
      if exception.is_a?(ActiveRecord::RecordNotFound)
          render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
      else
          render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false
      end
    end

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :phone_number])
    end
    
end
