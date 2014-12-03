Spree::Order.class_eval do

  state_machine do
    before_transition :to => :complete, :do => :calcuate_order_adjustement
  end

  def calcuate_order_adjustement
    updater.update_adjustment_total
    updater.update_order_total
    persist_totals
  end


  def cash_on_delivery_payment?
    payments && payments.last.payment_method.is_a?(Spree::CashOnDelivery::PaymentMethod)
  end

end
