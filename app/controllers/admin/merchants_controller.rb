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
      merchant.update(enabled?: false)
      merchant.items.update_all(active?: false)
      flash[:notice] = "Account for #{merchant.name} is now DISABLED."
      redirect_to '/admin/merchants'
    else
      merchant.update(enabled?: true)
      merchant.items.update_all(active?: true)

      flash[:notice] = "Account for #{merchant.name} is now ENABLED."
      redirect_to '/admin/merchants'
    end
  end
end
