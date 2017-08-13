class Admin::OrdersController < AdminController
  before_action :find_admin_order, except: [:index]

  def index
    @orders = Order.order("id DESC")
    if params[:total].present?
      @orders = @orders.where("total > ?", params[:total])
    end
    if params[:ids].present?
      @orders = @orders.where(:id => params[:ids].split(","))
    end
    if params[:status] == "pending"
      @orders = @orders.where(:aasm_state => ["order_placed", "paid"])
    elsif params[:status] == "done"
      @orders = @orders.where.not(:aasm_state => ["order_placed", "paid"])
    end
    if params[:date].present?
      d = Date.parse(params[:date])
      @orders = @orders.where(:created_at => d.beginning_of_day..d.end_of_day)
    end
  end

  def show
    @product_lists = @order.product_lists
  end

  def ship
    @order.ship!
    OrderMailer.notify_ship(@order).deliver!
    redirect_to :back
  end

  def shipped
    @order.deliver!
    redirect_to :back
  end

  def cancel
    @order.cancel_order!
    OrderMailer.notify_cancel(@order).deliver!
    redirect_to :back
  end

  def return
    @order.return_good!
    redirect_to :back
  end

  private

  def find_admin_order
    @order = Order.find(params[:id])
  end
end
