module Spree
  class Gateway::Migs < PaymentMethod::CreditCard
    preference :login, :string
    preference :password, :string
    preference :secure_hash, :string

    def provider_class
      ActiveMerchant::Billing::MigsGateway
    end
  end
end
