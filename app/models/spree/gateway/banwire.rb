module Spree
  class Gateway::Banwire < PaymentMethod::CreditCard
    preference :login, :string


    def gateway_class
      ActiveMerchant::Billing::BanwireGateway
    end

    def purchase(money, creditcard, gateway_options)
      gateway_options[:description] = "Spree Order"
      gateway.purchase(money, creditcard, gateway_options)
    end
  end
end
