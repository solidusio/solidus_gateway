Solidus Gateway
===============
Community supported Solidus Payment Methods. It works as a wrapper for
active_merchant gateways. Note that for some gateways you might still need to
add another gem to your Gemfile to make it work. For example, active_merchant
requires `braintree` but it doesn't include that gem on its gemspec. So you
need to add it to your rails app Gemfile manually.

---

**DEPRECATION NOTICE**

This extension is only ported over to Solidus to continue supporting stores upgrading from Spree.

For **new stores we strongly recommend** using one of these payment provider extensions:

* [`solidus_braintree_paypal`](https://github.com/solidusio/solidus_paypal_braintree) for Braintree provided payment methods like PayPal, Apple Pay and credit cards
* [`solidus_adyen`](https://github.com/StemboltHQ/solidus-adyen) for Adyen provided payment methods
* [`solidus_affirm`](https://github.com/solidusio-contrib/solidus_affirm) for Affirm provided payment methods
* [`solidus_stripe`](https://github.com/solidusio-contrib/solidus_stripe) for Stripe provided payment methods
* [`solidus_klarna_payments`](https://github.com/bitspire/solidus_klarna_payments)
* [`solidus_paybright`](https://github.com/StemboltHQ/solidus_paybright)

Although we will keep supporting Bug fixes for existing payment methods we **will not accept new payment methods** to be included in this gem.

Please create your own extension for new payment methods. Take one of the above examples as a starting point for your extension.

Installation
------------

In your Gemfile:

```ruby
gem "solidus_gateway"
```

Then run from the command line:

```shell
bundle install
rails g solidus_gateway:install
```

Finally, make sure to **restart your app**. Navigate to *Settings >
Payments > Payment Methods* in the admin panel.  You should see a number of payment
methods and the assigned provider for each.  Click on the payment method you wish
to change the provider, and you should see a number of options under the provider dropdown.

Testing
-------

Then just run the following to build a dummy app if necessary and automatically
run the tests:

```shell
bundle exec rake
```
