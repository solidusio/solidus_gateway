module Spree
  class Gateway::Paymill < PaymentMethod::CreditCard

    preference :public_key, :string
    preference :private_key, :string
    preference :currency, :string, :default => 'GBP'

    def gateway_class
      ActiveMerchant::Billing::PaymillGateway
    end
  end
end
