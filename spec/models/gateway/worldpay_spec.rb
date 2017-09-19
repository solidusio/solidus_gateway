require 'spec_helper'

describe Spree::Gateway::Worldpay do
  let(:gateway) { described_class.create!(name: 'Worldpay') }

  context '.gateway_class' do
    it 'is a Worldpay gateway' do
      expect(gateway.gateway_class).to eq ::ActiveMerchant::Billing::WorldpayGateway
    end
  end
end
