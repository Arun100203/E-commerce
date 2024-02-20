class Transaction < ApplicationRecord
    belongs_to :customerinfo
    belongs_to :product
    belongs_to :seller, class_name: 'Customerinfo', foreign_key: 'seller_id'

    after_save :send_transaction_email
    validates_presence_of :amount, :location, :product_id, :qty, :seller_id, :status, :customerinfo_id

    def send_transaction_email
        TransactionMailer.transaction_email(self).deliver_now
    end


    def self.ransackable_attributes(auth_object = nil)
        ["account_id", "amount", "created_at", "customerinfo_id", "date", "id", "id_value", "location", "product_id", "qty", "seller_id", "status", "updated_at"]
    end
end
