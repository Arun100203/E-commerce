ActiveAdmin.register Address do
    permit_params :customerinfo_id, :door_no, :street, :state, :pincode, :country

    menu label: "Addresses"

    controller { actions :all }    

    config.per_page = 10

end