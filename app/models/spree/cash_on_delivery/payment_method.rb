module Spree

  module CashOnDelivery

    class PaymentMethodConfiguration < Preferences::Configuration
      preference :charge, :string, :default => '5.0'
    end

    PAYMENT_CONFIG = PaymentMethodConfiguration.new

    class PaymentMethod < Spree::PaymentMethod

      # preference :charge, :string, :default => '5.0'

      def payment_profiles_supported?
        false # we want to show the confirm step.
      end


      def post_create(payment)
        adjustment = Spree::Adjustment.create(
            amount: PAYMENT_CONFIG.charge.to_f,
            order: payment.order,
            adjustable: payment.order,
            source: self,
            :mandatory => true,
            :included => true,
            label: I18n.t(:cash_on_delivery_label)
        )

        payment.order.adjustments << adjustment

        payment.update_attribute(:amount, payment.amount + PAYMENT_CONFIG.charge.to_f)
        payment.order.updater.update_adjustment_total
        payment.order.updater.update_order_total
        payment.order.persist_totals
        # end
      end

      def update_adjustment(adjustment, src)
        # if adjustment.adjustable.shipment.shipping_method.name != "Osebni prevzem" && !adjustment.adjustable.payments.empty?  && adjustment.adjustable.payments.last.payment_method.is_a?(Spree::CashOnDelivery::PaymentMethod)
        adjustment.update_attribute_without_callbacks(:amount, PAYMENT_CONFIG.charge.to_f)
        # else
        #adjustment.destroy
        # adjustment.update_attribute_without_callbacks(:amount, 0.0)
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
