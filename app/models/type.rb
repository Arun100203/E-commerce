class Type < ApplicationRecord
    has_many :product
    has_and_belongs_to_many :categories
    validates_presence_of :typeinfo

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "typeinfo", "updated_at"]
    end
end
