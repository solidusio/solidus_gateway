module Spree
  class Gateway::SagePay < PaymentMethod::CreditCard
    preference :login, :string
    preference :password, :string
    preference :account, :string

    def gateway_class
      ActiveMerchant::Billing::SagePayGateway
    end
  end
end
