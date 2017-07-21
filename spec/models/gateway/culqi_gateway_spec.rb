require 'spec_helper'

describe Spree::Gateway::CulqiGateway do
  let (:gateway) { described_class.create!(name: 'CulqiGateway') }

  context '.provider_class' do
    it 'is a Culqi gateway' do
      expect(gateway.provider_class).to eq ::ActiveMerchant::Billing::CulqiGateway
    end
  end
end
