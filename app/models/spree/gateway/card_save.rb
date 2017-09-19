module Spree
  class Gateway::CardSave < PaymentMethod::CreditCard
    preference :login, :string
    preference :password, :string

    def provider_class
      ActiveMerchant::Billing::CardSaveGateway
    end
  end
end