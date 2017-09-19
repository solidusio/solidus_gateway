module Spree
  class Gateway::DataCash < PaymentMethod::CreditCard
    preference :login, :string
    preference :password, :string

    def gateway_class
      ActiveMerchant::Billing::DataCashGateway
    end
  end
end
