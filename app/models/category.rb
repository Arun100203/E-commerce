class Category < ApplicationRecord
    has_many :products
    has_and_belongs_to_many :types
    validates_presence_of :category

    def self.ransackable_attributes(auth_object = nil)
        ["category", "created_at", "id", "id_value", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["products", "types"]
    end
end
