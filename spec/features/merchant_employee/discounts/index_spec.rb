require 'rails_helper'

RSpec.describe 'As a merchant employee' do
  before :each do
    @new_merchant = Merchant.create!(
      name: 'New shop',
      address: '123 Street Road',
      city: 'City Name',
      state: 'CO',
      zip: 80203
    )

    @merchant = @new_merchant.users.create!(
      name: 'Merchant',
      address: '123 Street Road',
      city: 'City Name',
      state: 'Nv',
      zip: '80203',
      email: 'merchant@merchant.com',
      password: 'merchant',
      role: 1
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

    @discount_1 = Discount.create!(
      name: 'Small Discount',
      item_threshold: 20,
      percentage_off: 5,
      merchant_id: @new_merchant.id
    )

    @discount_2 = Discount.create!(
      name: 'Big Discount',
      item_threshold: 40,
      percentage_off: 10,
      merchant_id: @new_merchant.id
    )

    visit '/merchant_employee/dashboard'
  end

  describe 'When I visit my dashboard' do
    it 'can click a link to see a discounts index page' do
      within '#discounts' do
        click_on 'My Discounts'
        expect(current_path).to eq(merchant_discounts_path)
      end
    end
  end
end
