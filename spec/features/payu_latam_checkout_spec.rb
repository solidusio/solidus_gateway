require 'spec_helper'

RSpec.describe "Payu Latam checkout", type: :feature do
  before do
    FactoryGirl.create(:store)
    # Set up a zone
    zone = FactoryGirl.create(:zone)
    country = FactoryGirl.create(:country)
    zone.members << Spree::ZoneMember.create!(zoneable: country)
    FactoryGirl.create(:free_shipping_method)

    Spree::Config.set(auto_capture: true)

    Spree::Gateway::PayuLatamGateway.create!(
      name: "Payu Latam",
      preferred_merchant_id: "508029",
      preferred_account_id: "512323",
      preferred_api_login: "pRRXKOl8ikMmt9u",
      preferred_api_key: "4Vj8eK4rloUd272L48hsrarnUA",
      preferred_public_key: "PKaC6H4cEDJD919n705L544kSU",
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

  it "can process a valid payment", js: true do
    sleep(5)
    # wait to complete payU.getPaymentMethods
    fill_in "Card Number", with: "4242 4242 4242 4242"
    # Otherwise ccType field does not get updated correctly
    page.execute_script("$('.cardNumber').trigger('change')")
    fill_in "Card Code", with: "123"
    fill_in "Expiration", with: "01 / #{Time.now.year + 1}"
    fill_in "customer_document", with: "78392890"
    click_button "Save and Continue"
    sleep(5)
    expect(page.current_url).to include("/checkout/confirm")
    click_button "Place Order"
    expect(page).to have_content("Your order has been processed successfully")
  end
end
