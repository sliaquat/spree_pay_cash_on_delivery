Spree::Payment.class_eval do

  # for Cash on Delivery
  #TODO: As it stands now, this method is copy from spree-core/app/models/spree/payment.rb Improve!
  def build_source
    return if source_attributes.nil? || !new_record?
    if payment_method and payment_method.respond_to?(:create_adjustment)
      payment_method.create_adjustment(self)
    elsif source.blank? && payment_method.try(:payment_source_class)
      self.source = payment_method.payment_source_class.new(source_attributes)
      self.source.payment_method_id = payment_method.id
      self.source.user_id = self.order.user_id if self.order
    end

  end

end

