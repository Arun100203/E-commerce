ActiveAdmin.register Product do
    permit_params :name, :description, :price, :total_stock_amount, :brand, :seller_id, :category_id, :type_id

    menu label: "Produtcs"

    filter :name
    # filter :frequently_sold, label: 'Frequently Sold Products', as: :numeric, collection: proc { Product.all.map { |product| [product.name, product.id] } }

    controller  { actions :all}

    controller do
        # def scoped_collection
        #     Product.frequently_sold_eq(5)
        # end
    end
        
    config.per_page = 10

end