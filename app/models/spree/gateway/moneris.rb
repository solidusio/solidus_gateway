module Spree
  class Gateway::Moneris < PaymentMethod::CreditCard
    preference :login, :string
    preference :password, :password

    def gateway_class
      ActiveMerchant::Billing::MonerisGateway
    end
  end
end
