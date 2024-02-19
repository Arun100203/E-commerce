ActiveAdmin.register Like do
    permit_params :isLiked, :likeable, :customerinfo_id

    menu label: "Likes"

    scope :product
    scope :comment

    controller { actions :all }

    config.per_page = 10

end