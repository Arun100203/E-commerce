module ControllerHelpers
    def sign_in(customerinfo = double('customerinfo'))
      if customerinfo.nil?
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {scope: :customerinfo})
        allow(controller).to receive(:current_customerinfo).and_return(nil)
      else
        allow(request.env['warden']).to receive(:authenticate!).and_return(customerinfo)
        allow(controller).to receive(:current_customerinfo).and_return(customerinfo)
      end
    end
  end