

module Spree
  module Admin
    class CashOnDeliveryConfigsController < Spree::Admin::BaseController

      def edit
        @charge = Spree::CashOnDelivery::Config.charge
      end

      def update
        Spree::CashOnDelivery::Config.charge = params[:cash_on_delivery_charge]
        flash[:success] = "Cash on delivery charge has been updated"
        redirect_to edit_admin_cash_on_delivery_configs_path
      end

    end
  end
end