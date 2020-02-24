class Admin::MerchantsController < Admin::BaseController

	def index
		@merchants = Merchant.all
	end

	def show
		@merchant = Merchant.find(params[:merchant_id])
	end

	def update
		merchant = Merchant.find(params[:id])
		if merchant.enabled?
			merchant.update(status: 1)
		else
			merchant.update(status: 0)
		end
		redirect_back(fallback_location: '/admin/merchants')
	end
end
