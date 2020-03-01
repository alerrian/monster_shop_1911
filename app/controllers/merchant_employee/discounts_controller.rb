class MerchantEmployee::DiscountsController < MerchantEmployee::BaseController
  def index
    @discounts = Discount.all
  end
end
