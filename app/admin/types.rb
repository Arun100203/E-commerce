ActiveAdmin.register Type do
    permit_params :typeinfo
    
    menu label: "Types"

        index do
            id_column
            column :typeinfo
        end

        filter :typeinfo

        form do |f|
            f.inputs do
              f.input :typeinfo
            end
            f.actions
          end
        
        config.per_page = 10
          
end