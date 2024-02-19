ActiveAdmin.register Cart do
    permit_params :customerinfo_id, :product_id

    menu label: "Carts"

    controller { actions :all }
        
    config.per_page = 10
end