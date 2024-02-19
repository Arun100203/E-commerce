class TransactionMailer < ApplicationMailer
    default from: "arunarunarun7354@gmail.com"

    def transaction_email(transaction)
        @transaction = transaction
        @product = Product.find(@transaction.product_id)
        @url  = 'http://localhost:3000/transactions'
        @customerinfo = Customerinfo.find(@transaction.customerinfo_id)
        mail(to: @customerinfo.email, subject: 'Thanks for your purchase!!!...')
    end
end
