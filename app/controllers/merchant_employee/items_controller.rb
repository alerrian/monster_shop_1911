class MerchantEmployee::ItemsController < MerchantEmployee::BaseController

	def index
		@merchant = Merchant.find(params[:id])
		@items = @merchant.items
	end

	def show
		@item = Item.find(params[:id])
		@merchant = @item.merchant
	end

	def new
		@merchant = Merchant.find(params[:id])
	end

	def create
		@merchant = Merchant.find(params[:id])
		@item = @merchant.items.create(item_params)
		if @item.save
			redirect_to "/merchant_employee/merchants/#{@merchant.id}/items"
		else
			flash[:error] = @item.errors.full_messages.to_sentence
			render :new
		end
	end

	def edit
    @item = Item.find(params[:id])
		@merchant = @item.merchant
  end

  def update
    @item = Item.find(params[:id])
		@merchant = @item.merchant
    @item.update(item_params)
    if @item.save
      redirect_to "/merchant_employee/merchants/#{@merchant.id}/items/#{@item.id}"
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
		@merchant = @item.merchant
    Review.where(item_id: @item.id).destroy_all
    @item.destroy
		flash[:notice] = "#{@item.name}, has been perminatley removed from inventory!"
    redirect_to "/merchant_employee/merchants/#{@merchant.id}/items"
  end

  private

  def item_params
    params.permit(
			:name,
			:description,
			:price,
			:inventory,
			:image
		)
  end
end
