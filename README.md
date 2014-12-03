SpreePayCashOnDelivery
======================

Adds 'Cash on delivery' payment method to Spree Commerce with ability to set delivery fees in the admin panel.
 

Installation
------------

Add spree_pay_cash_on_delivery to your Gemfile:

```ruby
gem 'spree_pay_cash_on_delivery', github: 'sliaquat/spree_pay_cash_on_delivery'
```

Then run:

```ruby
bundle install
```
 
Usage
-----
 
 - For adding 'Cash on delivery' payment method, log in to the admin back end ("http://localhost:3000/admin") and go to "Configurations" > "Payment Methods". Click "New Payment Method" and select 
 "Spree::CashOnDelivery::PaymentMethod" form the provider drop down. Save.
 
 
 - For setting the 'Cash on delivery' fee, log in to the admin back end ("http://localhost:3000/admin") and go to "Configurations" > "Cash on delivery config"

Copyright (c) 2014 Sanad Liaquat, released under the New BSD License
