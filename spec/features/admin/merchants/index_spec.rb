require 'rails_helper'

RSpec.describe 'As an Admin' do
	describe 'When I visit the merchants index page.' do
		before :each do
			@megs_shop = Merchant.create!(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203, enabled?: true)
			@brians_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210, enabled?: false)

			@admin = User.create!(name: "Admin", address: "123 Admin cir.", city: "The provinance of holeville", state: "Ca", zip: "83845", email: "admin@gmail.com", password: "admin", role: 2)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

			visit "/admin/merchants"

			expect(current_path).to eq("/admin/merchants")
	 	end
    
		it 'I see a list of all the Merchants on the website and their names are a hyperlink to their dashboards.' do

			expect(current_path).to eq("/admin/merchants")

			expect(page).to have_content(@megs_shop.name)
			expect(page).to have_content(@brians_shop.name)

			within "#merchant-#{@megs_shop.id}" do
				expect(page).to have_link(@megs_shop.name)

				click_on "#{@megs_shop.name}"

				expect(current_path).to eq("/admin/merchants/#{@megs_shop.id}")
			end
		end

		it 'merchant city and state' do
			within "#merchant-#{@megs_shop.id}" do
				expect(page).to have_content('Hershey')
				expect(page).to have_content('PA')
      end
      
			within "#merchant-#{@brians_shop.id}" do
				expect(page).to have_content('Denver')
				expect(page).to have_content('CO')
			end
		end

		it 'can disable/enable merchants' do
			within "#merchant-#{@megs_shop.id}" do
                                expect(page).to have_button('disable')
				click_button 'disable'
                                expect(page).to_not have_button('disable')
                                expect(page).to have_button('enable')
				click_button 'enable'
                                expect(page).to_not have_button('enable')	
      end     
    end
    
		it 'I can click on a DISABLE button next to any Merchants who are not yet disabled and their status becomes DISABLED' do

			visit "/admin/merchants"

			within "#merchant-#{@brians_shop.id}" do
				expect(page).not_to have_button("disable")
				expect(page).to have_content("Account Status: disabled")
			end

			within "#merchant-#{@megs_shop.id}" do
				expect(page).to have_button("disable")
				expect(page).to have_content("Account Status: enabled")

				click_on "disable"

				expect(current_path).to eq("/admin/merchants")
				expect(page).to have_content("Account Status: disabled")
			end

			expect(page).to have_content("Account for #{@megs_shop.name} is now DISABLED.")
		end

		it 'I can click ENABLE button next to any Merchants who are not yet enabled and their status becomes ENABLED' do

			visit "/admin/merchants"

			within "#merchant-#{@megs_shop.id}" do
				expect(page).not_to have_button("enable")
				expect(page).to have_content("Account Status: enabled")
			end

			within "#merchant-#{@brians_shop.id}" do
				expect(page).to have_button("enable")
				expect(page).to have_content("Account Status: disabled")

				click_on "enable"

				expect(current_path).to eq("/admin/merchants")
				expect(page).to have_content("Account Status: enabled")
			end

			expect(page).to have_content("Account for #{@brians_shop.name} is now ENABLED.")
		end
	end
end	
