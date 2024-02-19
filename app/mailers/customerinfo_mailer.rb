class CustomerinfoMailer < ApplicationMailer
    default from: "arunarunarun7354@gmail.com"

    def welcome_email(customerinfo)
        @customerinfo = customerinfo
        @url  = 'http://localhost:3000/login'
        mail(to: @customerinfo.email, subject: 'Welcome to Online Shopping!!!...')
    end
end
