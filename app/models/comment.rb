class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :customerinfo
  has_many :likes, as: :likeable
  validates_presence_of :body

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "customerinfo_id", "id", "id_value", "product_id", "timestamps", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customerinfo", "likes", "product"]
  end
  
end
