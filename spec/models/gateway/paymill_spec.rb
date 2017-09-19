require 'spec_helper'

describe Spree::Gateway::Paymill do
  let(:gateway) { described_class.create!(name: 'Paymill') }

  context '.gateway_class' do
    it 'is a Paymill gateway' do
      expect(gateway.gateway_class).to eq ::ActiveMerchant::Billing::PaymillGateway
    end
  end
end
