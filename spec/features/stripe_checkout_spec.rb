require 'spec_helper'

RSpec.describe "Stripe checkout", type: :feature do
  before do
    FactoryGirl.create(:store)
    # Set up a zone
    zone = FactoryGirl.create(:zone)
    country = FactoryGirl.create(:country)
    zone.members << Spree::ZoneMember.create!(zoneable: country)
    FactoryGirl.create(:free_shipping_method)

    Spree::Gateway::StripeGateway.create!(
      name: "Stripe",
      preferred_secret_key: "sk_test_VCZnDv3GLU15TRvn8i2EsaAN",
      preferred_publishable_key: "pk_test_Cuf0PNtiAkkMpTVC2gwYDMIg",
    )

    FactoryGirl.create(:product, name: "DL-44")

    visit spree.root_path
    click_link "DL-44"
    click_button "Add To Cart"

    expect(page).to have_current_path("/cart")
    click_button "Checkout"

    # Address
    expect(page).to have_current_path("/checkout/address")
    fill_in "Customer E-Mail", with: "han@example.com"
    within("#billing") do
      fill_in "First Name", with: "Han"
      fill_in "Last Name", with: "Solo"
      fill_in "Street Address", with: "YT-1300"
      fill_in "City", with: "Mos Eisley"
      select "United States of America", from: "Country"
      select country.states.first, from: "order_bill_address_attributes_state_id"
      fill_in "Zip", with: "12010"
      fill_in "Phone", with: "(555) 555-5555"
    end
    click_on "Save and Continue"

    # Delivery
    expect(page).to have_current_path("/checkout/delivery")
    expect(page).to have_content("UPS Ground")
    click_on "Save and Continue"

    expect(page).to have_current_path("/checkout/payment")
  end

  # This will fetch a token from Stripe.com and then pass that to the webserver.
  # The server then processes the payment using that token.
  it "can process a valid payment", js: true do
    fill_in "Card Number", with: "4242 4242 4242 4242"
    fill_in "Card Code", with: "123"
    fill_in "Expiration", with: "01 / #{Time.now.year + 1}"
    click_button "Save and Continue"
    expect(page).to have_current_path("/checkout/confirm")
    click_button "Place Order"
    expect(page).to have_content("Your order has been processed successfully")
  end

  it "shows an error with a missing credit card number", js: true do
    fill_in "Expiration", with: "01 / #{Time.now.year + 1}"
    click_button "Save and Continue"
    expect(page).to have_content("Could not find payment information")
  end

  it "shows an error with a missing expiration date", js: true do
    fill_in "Card Number", with: "4242 4242 4242 4242"
    click_button "Save and Continue"
    expect(page).to have_content("Your card's expiration year is invalid.")
  end

  it "shows an error with an invalid credit card number", js: true do
    fill_in "Card Number", with: "1111 1111 1111 1111"
    fill_in "Expiration", with: "01 / #{Time.now.year + 1}"
    click_button "Save and Continue"
    expect(page).to have_content("Your card number is incorrect.")
  end

  it "shows an error with invalid security fields", js: true do
    fill_in "Card Number", with: "4242 4242 4242 4242"
    fill_in "Expiration", with: "01 / #{Time.now.year + 1}"
    fill_in "Card Code", with: "12"
    click_button "Save and Continue"
    expect(page).to have_content("Your card's security code is invalid.")
  end

  it "shows an error with invalid expiry fields", js: true do
    fill_in "Card Number", with: "4242 4242 4242 4242"
    fill_in "Expiration", with: "00 / #{Time.now.year + 1}"
    fill_in "Card Code", with: "123"
    click_button "Save and Continue"
    expect(page).to have_content("Your card's expiration month is invalid.")
  end
end
