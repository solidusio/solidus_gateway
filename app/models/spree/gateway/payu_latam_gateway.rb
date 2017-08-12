module Spree
  class Gateway::PayuLatamGateway < Gateway
    preference :merchant_id, :string
    preference :account_id, :string
    preference :api_login, :string
    preference :api_key, :string

    def provider_class
      ActiveMerchant::Billing::PayuLatamGateway
    end
  end
end
