ActiveAdmin.register Customerinfo do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :phone_number, :cart_id, :category
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :phone_number, :cart_id, :category]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  menu label: "Customerinfo"

    index do
        id_column
        column :name
        column :email
        column :category
        column :phone_number   
        column "Account IDs" do |customerinfo|
          customerinfo.accounts.pluck(:id).join(', ')
        end
        column "Address IDs" do |customerinfo|
          customerinfo.addresses.pluck(:id).join(', ')
        end
    end

  filter :name
  filter :phone_number
  filter :email
  filter :category

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :phone_number
      f.input :category
    end
    f.actions
  end
 
  controller { actions :all }
  
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :phone_number, :cart_id, :category
  
  config.per_page = 10

end
