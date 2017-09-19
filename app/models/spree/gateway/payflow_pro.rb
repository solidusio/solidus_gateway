module Spree
  class Gateway::PayflowPro < PaymentMethod::CreditCard
    preference :login, :string
    preference :password, :password
    preference :partner, :string

    def gateway_class
      ActiveMerchant::Billing::PayflowGateway
    end

    def options
      super().merge(:test => self.preferred_test_mode)
    end
  end
end
