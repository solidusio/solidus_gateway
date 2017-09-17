module Spree
    class Gateway::Cardknox < PaymentMethod::CreditCard
      preference :api_key, :string

      def initialize(options)
      
        begin
          super(options)
        rescue
          # If the current version of ActiveMerchant doesn't include the Cardknox gateway
          puts "Cardknox is not supported by this version of ActiveMerchant"
        end
      end
  
      def gateway_class
        ActiveMerchant::Billing::CardknoxGateway
      end
      
    end
end

# A hack because ActiveMerchant's CardknoxGateway class returned an error when a paymentmethod was submitted that didn't respond to track_data and manual_entry methods
# Can be removed when Pull Request #2580 is merged to ActiveMerchant

module AdditionalMethods
    attr_accessor :track_data, :manual_entry
end

Spree::CreditCard.include(AdditionalMethods)