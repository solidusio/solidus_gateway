module Spree
  class Gateway::SecurePayAU < PaymentMethod::CreditCard
    preference :login, :string
    preference :password, :string

    def gateway_class
      ActiveMerchant::Billing::SecurePayAuGateway
    end
  end
end
