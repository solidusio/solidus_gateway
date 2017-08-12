require 'spec_helper'

describe Spree::Gateway::PayuLatamGateway do
  let(:gateway) { described_class.create!(name: 'PayuLatamGateway') }

  context '.provider_class' do
    it 'is a PayuLatam gateway' do
      expect(gateway.provider_class).to eq ::ActiveMerchant::Billing::PayuLatamGateway
    end
  end
end
