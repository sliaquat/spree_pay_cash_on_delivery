Deface::Override.new(virtual_path: "spree/admin/shared/sub_menu/_configuration",
                     name: "cash_on_delivery_config_settings_added_to_configuration_menu",
                     insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
                     partial: "spree/admin/shared/cash_on_delivery_config_settings"
)