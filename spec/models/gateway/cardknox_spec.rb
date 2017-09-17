require 'spec_helper'

describe Spree::Gateway::Cardknox do

  # First make sure the version of ActiveMerchant being used supports the Cardknox gateway
  describe "Cardknox", if: (!!ActiveMerchant::Billing::CardknoxGateway rescue false) do

    before do
      Spree::Gateway.update_all(active: false)
      @gateway = Spree::Gateway::Cardknox.create!(name: 'CardKnox', active: true)
      @gateway.set_preference(:api_key, 'YechielDev_Test_e2bea4d044a44522aa224aad2e3b8')
      @gateway.save!

      country = create(:country, name: 'United States', iso_name: 'UNITED STATES', iso3: 'USA', iso: 'US', numcode: 840)
      state = create(:state, name: 'Maryland', abbr: 'MD', country: country)
      address = create(:address,
        firstname: 'John',
        lastname:  'Doe',
        address1:  '1234 My Street',
        address2:  'Apt 1',
        city:      'Washington DC',
        zipcode:   '20123',
        phone:     '(555)555-5555',
        state:     state,
        country:   country)

      order = create(:order_with_totals, bill_address: address, ship_address: address)
      order.recalculate

      credit_card = create(:credit_card,
        verification_value: '123',
        number:             '4444333322221111',
        month:              9,
        year:               Time.now.year + 1,
        name:               'John Doe',
        cc_type:             'visa')

      @payment = create(:payment, source: credit_card, order: order, payment_method: @gateway, amount: 10.00)
    end

    it 'can purchase' do
      @payment.purchase!
      expect(@payment.state).to eq 'completed'
    end

    context '.gateway_class' do
      it 'is a Cardknox gateway' do
        expect(@gateway.gateway_class).to eq ::ActiveMerchant::Billing::CardknoxGateway
      end
    end

  end

end
