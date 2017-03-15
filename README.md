Solidus Gateway
===============

Community supported Solidus Payment Method Gateways. It works as a wrapper for
active_merchant gateway. Note that for some gateways you might still need to
add another gem to your Gemfile to make it work. For example active_merchant
require `braintree` but it doesn't include that gem on its gemspec. So you
need to manually add it to your rails app Gemfile.

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

Then just run the following to automatically build a dummy app if necessary and
run the tests:

```shell
bundle exec rake
```
