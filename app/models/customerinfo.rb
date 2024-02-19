class Customerinfo < ApplicationRecord

  
  has_many :accounts, dependent: :destroy
  has_many :comments, dependent: :destroy, foreign_key: 'customerinfo_id'
  has_many :likes, dependent: :destroy
  has_many :products, through: :likes
  has_many :addresses, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :transactions
  has_many :selling_transactions, class_name: 'Transaction', foreign_key: 'seller_id'
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :phone_number, presence: true, length: { minimum: 8, maximum: 10 }
  validates_associated :addresses, :accounts, :carts, :comments, :likes, :transactions, on: :create

  has_many :access_grants,
         class_name: 'Doorkeeper::AccessGrant',
         foreign_key: :resource_owner_id,
         dependent: :delete_all 

  has_many :access_tokens,
         class_name: 'Doorkeeper::AccessToken',
         foreign_key: :resource_owner_id,
         dependent: :delete_all 
        
  after_save :send_welcome_email
  
  def send_welcome_email
    CustomerinfoMailer.welcome_email(self).deliver_now
  end

  # for checking if a customer has liked a product or comment
  def likes?(likeable)
    likes.exists?(likeable: likeable)
  end

  def self.authenticate(email, password)
    customerinfo = Customerinfo.find_for_authentication(email: email)
    customerinfo&.valid_password?(password) ? customerinfo : nil
  end

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "category", "created_at", "email", "encrypted_password", "id", "id_value", "name", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

end
