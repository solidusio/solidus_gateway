module Spree
  class Gateway::UsaEpay < PaymentMethod::CreditCard
    preference :login, :string

    def gateway_class
      ActiveMerchant::Billing::UsaEpayGateway
    end
  end
end
