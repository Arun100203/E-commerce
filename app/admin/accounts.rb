ActiveAdmin.register Account do

    permit_params :customerinfo_id, :ifsc, :account_no, :bank_name

    menu label: "Accounts"

    
    controller { actions :all }

    config.per_page = 10

end