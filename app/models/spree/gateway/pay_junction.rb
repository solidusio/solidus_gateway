module Spree
  class Gateway::PayJunction < PaymentMethod::CreditCard
    preference :login, :string
    preference :password, :string

    def gateway_class
      ActiveMerchant::Billing::PayJunctionGateway
    end

    def options
      super().merge(:test => self.preferred_test_mode)
    end
  end
end
