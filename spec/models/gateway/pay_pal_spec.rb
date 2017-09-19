require 'spec_helper'

describe Spree::Gateway::PayPalGateway do
  let(:gateway) { described_class.create!(name: 'PayPal') }

  context '.gateway_class' do
    it 'is a PayPal gateway' do
      expect(gateway.gateway_class).to eq ::ActiveMerchant::Billing::PaypalGateway
    end
  end
end