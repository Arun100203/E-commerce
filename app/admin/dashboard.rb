# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recently Uploaded Products" do
          ul do
            Product.order(created_at: :desc).limit(10).map do |product|
              li link_to(product.name, product_path(product.id))
              li "Sold at : #{product.created_at}"
            end
          end
        end
      end

      column do
        panel "Recent Transaction" do
          ul do
            Transaction.order(created_at: :desc).limit(10).map do |transaction|
              li link_to("Transaction Id : #{transaction.id}", "/admin/transactions/#{transaction.id}")
            end
          end
        end
      end
    end
  end # content
end
