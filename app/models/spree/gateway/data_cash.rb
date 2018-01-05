require 'active_merchant/billing/gateways/data_cash'

module Spree
  class Gateway::DataCash < Gateway
    preference :login, :string
    preference :password, :string

    def provider_class
      ActiveMerchant::Billing::DataCashGateway
    end
  end
end
