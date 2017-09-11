module Spree
  class Gateway::Cardknox < Gateway
    preference :api_key, :string

    def provider_class
      ActiveMerchant::Billing::CardknoxGateway
    end
  end
end
