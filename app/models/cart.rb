class Cart < ApplicationRecord
    has_many :products
    belongs_to :customerinfo


    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "customerinfo_id", "id", "id_value", "product_id", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["customerinfo", "products"]
    end
end
