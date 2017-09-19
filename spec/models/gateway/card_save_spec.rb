require 'spec_helper'

describe Spree::Gateway::CardSave do
  let(:gateway) { described_class.create!(name: 'CardSave') }

  context '.gateway_class' do
    it 'is a CardSave gateway' do
      expect(gateway.gateway_class).to eq ::ActiveMerchant::Billing::CardSaveGateway
    end
  end
end