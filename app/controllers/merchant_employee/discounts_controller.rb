class MerchantEmployee::DiscountsController < MerchantEmployee::BaseController
  def index
    merchant = current_user.merchant
    @discounts = Discount.where(merchant: merchant)
  end
end
