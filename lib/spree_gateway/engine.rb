module SpreeGateway
  class Engine < Rails::Engine
    engine_name 'solidus_gateway'

    initializer "spree.gateway.payment_methods", :after => "spree.register.payment_methods" do |app|
        app.config.spree.payment_methods << Spree::Gateway::AuthorizeNetCim
        app.config.spree.payment_methods << Spree::Gateway::AuthorizeNet
        app.config.spree.payment_methods << Spree::Gateway::CardSave
        app.config.spree.payment_methods << Spree::Gateway::Eway
        app.config.spree.payment_methods << Spree::Gateway::Linkpoint
        app.config.spree.payment_methods << Spree::Gateway::Moneris
        app.config.spree.payment_methods << Spree::Gateway::PayJunction
        app.config.spree.payment_methods << Spree::Gateway::PayPalGateway
        app.config.spree.payment_methods << Spree::Gateway::SagePay
        app.config.spree.payment_methods << Spree::Gateway::Beanstream
        app.config.spree.payment_methods << Spree::Gateway::BraintreeGateway
        app.config.spree.payment_methods << Spree::Gateway::StripeGateway
        app.config.spree.payment_methods << Spree::Gateway::Worldpay
        app.config.spree.payment_methods << Spree::Gateway::Banwire
        app.config.spree.payment_methods << Spree::Gateway::UsaEpay
        app.config.spree.payment_methods << Spree::Gateway::BalancedGateway
        app.config.spree.payment_methods << Spree::Gateway::DataCash
        app.config.spree.payment_methods << Spree::Gateway::PinGateway
        app.config.spree.payment_methods << Spree::Gateway::Paymill
        app.config.spree.payment_methods << Spree::Gateway::PayflowPro
        app.config.spree.payment_methods << Spree::Gateway::SecurePayAU
        app.config.spree.payment_methods << Spree::Gateway::Maxipago
        app.config.spree.payment_methods << Spree::Gateway::Migs
        app.config.spree.payment_methods << Spree::Gateway::SpreedlyCoreGateway
        app.config.spree.payment_methods << Spree::Gateway::CulqiGateway
    end

    # The application_id is a class attribute on all gateways and is used to
    # identify the "source" of the transaction. Braintree has asked us to
    # provide this value to attribute transactions to Solidus; we do not set
    # it on all gateways or the base gateway as other gateways' behavior with
    # the value may differ.
    initializer "spree.gateway.braintree_gateway.application_id" do |app|
      # NOTE: if the braintree gem is not loaded, calling ActiveMerchant::Billing::BraintreeBlueGateway crashes
      # therefore, check here to see if Braintree exists before trying to call it
      if defined?(Braintree)
        ActiveMerchant::Billing::BraintreeBlueGateway.application_id = "Solidus"
      end
    end

    if SolidusSupport.backend_available?
      paths["app/views"] << "lib/views/backend"
    end

    if SolidusSupport.frontend_available?
      paths["app/views"] << "lib/views/frontend"
    end
  end
end
