class Product < ApplicationRecord
    has_many :likes, as: :likeable
    has_one_attached :image
    has_many :comments, dependent: :destroy
    belongs_to :category
    belongs_to :type
    has_many :transactions

    validates_presence_of :name, :price, :total_stock_amount, :description
    validates :total_stock_amount, numericality: { only_integer: true, greater_than: 0 }
    validates :price, comparison: { greater_than: 0 }
    validates_associated :category, :type, :comments, :likes, :transactions, on: :create


    def self.frequently_sold_eq(value)
        Product.joins(:transactions).group("products.id").having("count(transactions.id) > ?", value)
    end

    
    def self.ransackable_associations(auth_object = nil)
        ["category", "comments", "image_attachment", "image_blob", "likes", "transactions", "type"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["brand", "category_id", "created_at", "description", "id", "id_value", "name", "price", "seller_id", "total_stock_amount", "type_id", "updated_at"]
    end

end
