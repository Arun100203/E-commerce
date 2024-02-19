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
        customerinfo { association :customerinfo }
    end

    factory :address do
        door_no { "123" }
        street { "Main Street" }
        state { "Tamil Nadu" }
        country { "India" }
        pincode { 600001 }
        customerinfo { association :customerinfo }
    end

    factory :cart do
        product_id { association :product }
        customerinfo_id { association :customerinfo }
    end

    factory :category do
        category { "Silk"}
    end

    factory :like do
        customerinfo { association :customer }
        trait :comment do
            association :likeable, factory: :comment
        end

        trait :product do
            association :likeable, factory: :product
        end
    end

    factory :transaction do
        customerinfo { association :customerinfo }
        product { association :product }
        qty { 1 }
        amount { 1 }
        seller_id { association :customerinfo }
        status { "MyString" }
        location { "MyString" }
        account { association :account }
        date { "2021-05-25" }
    end

    factory :type do
        typeinfo { "shirt" }
    end

    factory :product do
        name { "MyString" }
        description { "MyText" }
        price { 1 }
        total_stock_amount { 1 }
        seller_id { "1" }
        association :category 
        association :type
    end
end