ActiveAdmin.register Comment do
    permit_params :product_id, :customerinfo_id, :body, :timestamps
    config.comments = false
    
    menu label: "Comments"

    controller { actions :all }
        
    config.per_page = 10

end