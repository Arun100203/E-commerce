ActiveAdmin.register Category do
    permit_params :category
    
    menu label: "Categories"

    controller { actions :all }

    config.per_page = 10
    filter :category, as: :select
end
