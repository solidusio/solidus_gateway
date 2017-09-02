module Spree
  class Gateway::PayuLatamGateway < Gateway
    preference :merchant_id, :string
    preference :account_id, :string
    preference :api_login, :string
    preference :api_key, :string

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
  end
end
