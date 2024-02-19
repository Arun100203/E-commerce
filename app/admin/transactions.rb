ActiveAdmin.register Transaction do

    permit_params :customerinfo_id, :product_id, :seller_id, :account_id, :qty, :amount, :location, :date, :created_at
    
    menu label: "Transactions"

    index do
        id_column
        column 'Customer ID', :customerinfo_id
        column :product_id
        column :seller_id
        column :account_id
        column :status
        column :location
        column :created_at
        column :amount
    end

    filter :customerinfo_id
    filter :product_id
    filter :seller_id
    filter :account_id
    filter :status
    filter :location
    filter :created_at
    filter :amount

    form do |f|
        f.inputs do
            f.input :customerinfo_id
            f.input :product_id
            f.input :seller_id
            f.input :account_id
            f.input :status
            f.input :location
            f.input :created_at
            f.input :amount
        end
        f.actions
      end
    
    config.per_page = 10

    # customize name
end