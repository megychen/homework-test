class Admin::OrdersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required
  before_action :find_admin_order, except: [:index]

  def index
    @orders = Order.order("id DESC")
  end

  def show
  end

  def ship
    @order.ship!
    redirect_to :back
  end

  def shipped
    @order.delivery!
    redirect_to :back
  end

  def cancel!
    @order.cancel_order!
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
