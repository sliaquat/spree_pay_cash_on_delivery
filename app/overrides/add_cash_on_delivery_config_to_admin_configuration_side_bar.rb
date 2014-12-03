Deface::Override.new(virtual_path: "spree/admin/shared/_configuration_menu",
                     name: "cash_on_delivery_config_settings_added_to_configuration_menu",
                     insert_bottom: ".sidebar",
                     # :text => "<%= configurations_sidebar_menu_item Spree.t(:theme_settings), edit_admin_theme_settings_path %>",
                     partial: "spree/admin/shared/cash_on_delivery_config_settings"
)
