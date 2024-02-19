class Address < ApplicationRecord
    belongs_to :customerinfo
    validates_presence_of :door_no, :street, :state, :country, :pincode

    def self.ransackable_attributes(auth_object = nil)
        ["address_id", "country", "created_at", "customerinfo_id", "door_no", "id", "id_value", "pincode", "state", "street", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["customerinfo"]
    end
end
