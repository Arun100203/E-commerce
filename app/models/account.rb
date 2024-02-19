class Account < ApplicationRecord
    belongs_to :customerinfo
    has_many :transactions
    validates :account_no, presence: true, length: { minimum: 8, maximum: 20 }
    validates :bank_name, presence: true
    validates :ifsc, presence: true, length: { minimum: 8, maximum: 20 }


    def self.ransackable_attributes(auth_object = nil)
        ["account_id", "account_no", "bank_name", "created_at", "customerinfo_id", "id", "id_value", "ifsc", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["customerinfo"]
    end
end
