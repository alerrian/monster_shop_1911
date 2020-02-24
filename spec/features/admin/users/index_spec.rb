require 'rails_helper'
  
RSpec.describe 'As an Admin' do
        describe 'When I visit the users index page.' do
                before :each do
                        @brians_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
                        @admin = User.create!(name: "Admin", address: "123 Admin cir.", city: "The provinance of holeville", state: "Ca", zip: "83845", email: "admin@gmail.com", password: "admin", role: 2)
			@merchant_2 = @brians_shop.users.create!(name: "Meg", address: "123 merchant ave.", city: "City of Townsville", state: "Nv", zip: "39433", email: "merchant2@gmail.com", password: "merchant2", role: 1)
			@user = User.create!(name: 'person', address: '123 W', city: 'a', state: 'IN', zip: 12345, email: 'user@gmail.com', password: 'user', role: 0)
                        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

                        visit "/admin/users"
                end
		
		it 'all users in system, name which is link to show page, date, type' do
			within "#admins" do
				expect(page).to have_content("Admin")
			end
			within "#users" do
				expect(page).to have_content("person")
			end
			within "#merchants" do
				expect(page).to have_content("Meg")
			end
		end

		it 'can access a users show page' do
			within "#users" do
				click_link 'person'
				expect(current_path).to eq("/admin/users/#{@user.id}")
                        end
			expect(page).to have_content('Address: 123 W')
			expect(page).to have_content('a IN, 12345')
			expect(page).to_not have_content('Edit')

		end
	end
end

