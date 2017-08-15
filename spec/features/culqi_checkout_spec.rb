require "helpers/culqi_helper"

RSpec.describe "Culqi checkout", type: :feature do
  stub_authorization!

  before do
    setup_store
    setup_culqi_gateway
    checkout_until_payment

    fill_in "Card Number", with: "4111 1111 1111 1111"
    page.execute_script("$('.cardNumber').trigger('change')")
    fill_in "Card Code", with: "123"
    fill_in "Expiration", with: "09 / 20"
    click_button "Save and Continue"
    sleep(5) # Wait for API to return + form to submit
    find(".culqiInstallments").select("2")
    click_button "Save and Continue"
  end

  context "with process checkout" do
    before do
      expect(page.current_url).to include("/checkout/confirm")
      click_button "Place Order"
    end

    it "process order", js: true do
      expect(page).to have_content("Your order has been processed successfully")
    end

    it "capture payment", js: true do
      visit spree.admin_order_payments_path(Spree::Order.last)
      sleep(3)
      click_icon(:capture)
      expect(page).to have_content("Payment Updated")
    end

    it "voids a payment", js: true do
      visit spree.admin_order_payments_path(Spree::Order.last)
      sleep(3)
      click_icon(:void)
      expect(page).to have_content("Payment Updated")
    end
  end
end
