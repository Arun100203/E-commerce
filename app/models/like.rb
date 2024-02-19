class Like < ApplicationRecord
  belongs_to :customerinfo
  belongs_to :likeable, polymorphic: true
  scope :product, -> { where(likeable_type: 'Product') }
  scope :comment, -> { where(likeable_type: 'Comment')}

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customerinfo_id", "id", "id_value", "isLiked", "likeable_id", "likeable_type", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customerinfo", "likeable"]
  end
  
end
