module Spree
  class Gateway::PayuLatamGateway < Gateway
    preference :merchant_id, :string
    preference :account_id, :string
    preference :api_login, :string
    preference :api_key, :string
    preference :public_key, :string

    def provider_class
      ActiveMerchant::Billing::PayuLatamGateway
    end

    if SolidusSupport.solidus_gem_version < Gem::Version.new('2.3.x')
      def method_type
        'payu_latam'
      end
    else
      def partial_name
        'payu_latam'
      end
    end

    def authorize(amount, credit_card, gateway_options)
      authorization = authorization_str(credit_card)
      provider.authorize(amount, authorization, gateway_options)
    end

    def purchase(amount, credit_card, gateway_options)
      authorization = authorization_str(credit_card)
      options = add_missing_fields(gateway_options, credit_card[:gateway_customer_profile_id])
      provider.purchase(amount, authorization, options)
    end

    private

    def authorization_str(credit_card)
      "#{credit_card[:cc_type]}|#{credit_card[:gateway_payment_profile_id]}"
    end

    def add_missing_fields(options, dni_number)
      options.merge(
        buyer_email: options[:email],
        buyer_name: options[:shipping_address][:name],
        buyer_dni_number: dni_number,
        dni_number: dni_number
      )
    end
  end
end
