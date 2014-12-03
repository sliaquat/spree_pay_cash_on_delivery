module Spree

  module CashOnDelivery


    class PaymentMethod < Spree::PaymentMethod

      def payment_profiles_supported?
        false # we want to show the confirm step.
      end


      def create_adjustment(payment)
        adjustment = Spree::Adjustment.create(
            amount: Spree::CashOnDelivery::Config.charge.to_f,
            order: payment.order,
            adjustable: payment.order,
            source: self,
            :mandatory => true,
            :included => true,
            label: "Cash On Delivery Fee"
        )

        payment.order.adjustments << adjustment

        payment.update_attribute(:amount, payment.amount + Spree::CashOnDelivery::Config.charge.to_f)
        payment.order.updater.update_adjustment_total
        payment.order.updater.update_order_total
        payment.order.persist_totals
        # end
      end


      def authorize(*args)
        ActiveMerchant::Billing::Response.new(true, "", {}, {})
      end

      def capture(payment, source, gateway_options)
        ActiveMerchant::Billing::Response.new(true, "", {}, {})
      end

      def void(*args)
        ActiveMerchant::Billing::Response.new(true, "", {}, {})
      end

      def actions
        %w{capture void}
      end

      def can_capture?(payment)
        payment.state == 'pending' || payment.state == 'checkout'
      end

      def can_void?(payment)
        payment.state != 'void'
      end

      def source_required?
        false
      end

      #def provider_class
      #  self.class
      #end

      def payment_source_class
        nil
      end

      def method_type
        'cash_on_delivery'
      end

      def auto_capture?
        true
      end

    end
  end
end
