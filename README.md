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
rails g spree_gateway:install
```

Finally, make sure to **restart your app**. Navigate to *Configuration >
Payment Methods > New Payment Method* in the admin panel and you should see
that a bunch of additional gateways have been added to the list.

Testing
-------

Until Solidus is publicly available, the easiest way to satisfy the Solidus
dependancy is with a local Bundler override:

```shell
bundle config local.spree /path/to/local/solidus/repository
```

Then just run the following to automatically build a dummy app if necessary and
run the tests:

```shell
bundle exec rake
```
