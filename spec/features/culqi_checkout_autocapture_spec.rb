require "helpers/culqi_helper"

RSpec.describe "Culqi checkout autocapture", type: :feature do
  before do
    setup_store
    Spree::Config.set(auto_capture: true)
    setup_culqi_gateway
    checkout_until_payment
  end

  context "with valid credit card" do
    stub_authorization!

    before do
      fill_in "Card Number", with: "4111 1111 1111 1111"
      page.execute_script("$('.cardNumber').trigger('change')")
      fill_in "Card Code", with: "123"
      fill_in "Expiration", with: "09 / 20"
      click_button "Save and Continue"
      sleep(5) # Wait for API to return + form to submit
      click_button "Save and Continue"
    end

    it "can process a valid payment", js: true do
      expect(page.current_url).to include("/checkout/confirm")
      click_button "Place Order"
      expect(page).to have_content("Your order has been processed successfully")
    end

    it "refunds a payment", js: true do
      reason = FactoryGirl.create(:refund_reason)

      click_button "Place Order"
      visit spree.admin_order_payments_path(Spree::Order.last)
      sleep(3)
      click_icon(:reply)
      fill_in "Amount", with: Spree::Order.last.amount.to_f
      select reason.name, from: "Reason", visible: false
      click_on "Refund"
      expect(Spree::Refund.count).to be(1)
    end
  end

  context "when missing credit card number" do
    it "shows an error", js: true do
      fill_in "Expiration", with: "01 / #{Time.now.year + 1}"
      fill_in "Card Code", with: "123"
      click_button "Save and Continue"
      expect(page).to have_content("El numero de tarjeta de crédito o débito brindado no es válido.")
    end
  end

  context "when missing expiration date" do
    it "shows an error", js: true do
      fill_in "Card Number", with: "4242 4242 4242 4242"
      fill_in "Card Code", with: "123"
      click_button "Save and Continue"
      expect(page).to have_content("de expiración de tu tarjeta es inválido.")
    end
  end

  context "with an invalid credit card number" do
    it "shows an error", js: true do
      fill_in "Card Number", with: "1111 1111 1111"
      fill_in "Expiration", with: "02 / #{Time.now.year + 1}"
      fill_in "Card Code", with: "123"
      click_button "Save and Continue"
      expect(page).to have_content("El numero de tarjeta de crédito o débito brindado no es válido.")
    end
  end
end
