class Order < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

	belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status: ['pending', 'packaged', 'shipped', 'cancelled']

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def item_count
    items.sum(:quantity)
  end

  def items_in_order
    items
  end

  def cancel
    update(status: 'cancelled')

    # item_orders.each do |order|
    #   order.update(status: 'unfulfilled')
    #   order.item.update(inventory: (order.item.inventory + order.quantity))
    # end
  end

  def self.sort_status
    order(status: :ASC)
  end

  def try_package
    update(status: 'packaged') if item_orders.distinct.pluck(:status).first == 'fulfilled'
  end

	def merchant_total(merchant_id)
		item_orders.joins("JOIN items ON item_orders.item_id = items.id").where("items.merchant_id = #{merchant_id}").sum('item_orders.price * item_orders.quantity')
	end

	def merchant_quantity(merchant_id)
		item_orders.joins("JOIN items ON item_orders.item_id = items.id").where("items.merchant_id = #{merchant_id}").sum('item_orders.quantity')
	end
end
