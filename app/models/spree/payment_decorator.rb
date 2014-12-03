Spree::Payment.class_eval do
  # has_one :adjustment, :as => :source, :dependent => :destroy

  # for Cash on Delivery
  def build_source
    return if source_attributes.nil?

    if payment_method and payment_method.respond_to?(:post_create)
      payment_method.post_create(self)
    end

    # if payment_method and payment_method.payment_source_class
    #   self.source = payment_method.payment_source_class.new(source_attributes)
    # end
  end

end



# module PaymentExtensions
#   # extend ActiveSupport::Concern
#
#
#   PaymentExtensions.included ()do
#     prepend InstanceMethods
#   end
#
#
#   module InstanceMethods
#     def build_source_override
#       byebug
#       # do before work
#       super # do original work
#       # do after work
#       if payment_method and payment_method.respond_to?(:post_create)
#         payment_method.post_create(self)
#       end
#
#     end
#
#   end
# end
# Spree::Payment.include PaymentExtensions