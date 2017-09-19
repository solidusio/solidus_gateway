require 'spec_helper'

describe Spree::Gateway::CulqiGateway do
  let (:gateway) { described_class.new }

  context '.provider_class' do
    it 'is a CulqiGateway gateway' do
      expect(gateway.provider_class).to eq ::Spree::Gateway::CulqiGateway
    end
  end
end
