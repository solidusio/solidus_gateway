module Spree
  class Gateway::CulqiGateway < Gateway
    preference :merchant_id, :string
    preference :terminal_id, :string
    preference :secret_key, :string

    def provider_class
      ActiveMerchant::Billing::CulqiGateway
    end
  end
end
