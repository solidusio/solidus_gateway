module Spree
  class Gateway::BalancedGateway < PaymentMethod::CreditCard
    preference :login, :string
    preference :on_behalf_of_uri, :string

    def authorize(money, creditcard, gateway_options)
      if token = creditcard.gateway_payment_profile_id
        # The Balanced ActiveMerchant gateway supports passing the token directly as the creditcard parameter
        creditcard = token
      end
      gateway.authorize(money, creditcard, gateway_options)
    end

    def capture(authorization, creditcard, gateway_options)
      gateway_options[:on_behalf_of_uri] = self.preferred_on_behalf_of_uri
      gateway.capture((authorization.amount * 100).round, authorization.response_code, gateway_options)
    end

    def create_profile(payment)
      return unless payment.source.gateway_payment_profile_id.nil?

      options = {}
      options[:email] = payment.order.email
      options[:login] = preferred_login

      card_store_response = gateway.store(payment.source, options)
      card_uri = card_store_response.authorization.split(';').first

      # A success just returns a string of the token. A failed request returns a bad request response with a message.
      payment.source.update_attributes!(:gateway_payment_profile_id => card_uri)
    rescue Error => ex
      payment.send(:gateway_error, ex.message)
    end

    def options
      super().merge(:test => self.preferred_test_mode)
    end

    def payment_profiles_supported?
      true
    end

    def purchase(money, creditcard, gateway_options)
      if token = creditcard.gateway_payment_profile_id
        # The Balanced ActiveMerchant gateway supports passing the token directly as the creditcard parameter
        creditcard = token
      end
      gateway.purchase(money, creditcard, gateway_options)
    end

    def gateway_class
      ActiveMerchant::Billing::BalancedGateway
    end

    def credit(money, creditcard, response_code, gateway_options)
      gateway.refund(money, response_code, {})
    end

    def void(response_code, creditcard, gateway_options)
      gateway.void(response_code)
    end

  end
end
