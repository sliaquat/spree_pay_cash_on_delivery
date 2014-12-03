class Spree::PaymentMethodConfiguration <  Spree::Preferences::Configuration
  preference :charge, :string, :default => '5.0'
end