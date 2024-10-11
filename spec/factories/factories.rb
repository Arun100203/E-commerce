FactoryBot.define do
    factory :customerinfo do
      sequence :email do |n|
        "elisadas345+#{n}@gmail.com" 
      end
      password { "123456" }
      name { "Test" }
      phone_number { 1234567890 }
    end

    factory :account do
        ifsc { "SBIN0000001" }
        account_no { 123456789 }
        bank_name { "SBI" }
        customerinfo_id { Customerinfo.last.id }
    end

    factory :address do
        door_no { "123" }
        street { "Main Street" }
        state { "Tamil Nadu" }
        country { "India" }
        pincode { 600001 }
        customerinfo_id { Customerinfo.last.id }
    end

    factory :cart do
        product_id { Product.last.id }
        customerinfo_id { Customerinfo.last.id }
    end

    factory :category do
        category { "Silk"}
    end

    factory :category_1 , as "Category" do
        category { "Nylon"}
    end

    factory :like do
        customerinfo { Customerinfo.last }
        likeable { Product.last }

        trait :comment do
            association :likeable, factory: :comment
        end

        trait :product do
            association :likeable, factory: :product
        end
    end

    factory :transaction do
        customerinfo { Customerinfo.last }
        product { Product.last }
        qty { 1 }
        amount { 1 }
        seller_id { Customerinfo.last.id.to_s }
        status { "MyString" }
        location { "MyString" }
        account_id { 1 }
        date { Date.today }
    end

    factory :type do
        typeinfo { "shirt" }
    end

    factory :comment do
        body { "MyText" }
        customerinfo_id { Customerinfo.last.id }
        product_id { Product.last.id }
    end

    factory :product do
        name { "MyString" }
        description { "MyText" }
        price { 1 }
        brand { "MyString" }
        total_stock_amount { 1 }
        seller_id { Customerinfo.last.id.to_s }
        category_id { Category.first.id }
        type_id { Type.first.id }
    end
end

def factory_for_product_likeable
    FactoryBot.create(:like, :product, likeable_id: Product.last.id, likeable_type: "Product")
end

def factory_for_comment_likeable
    FactoryBot.create(:like, :comment, likeable_id: Comment.last.id, likeable_type: "Comment")
end