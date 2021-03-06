class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :find_categories
  before_filter :initialize_cart

  def initialize_cart
    @cart = Cart.build_from_hash(session)
  end

  def clear_cart
    session[:cart] = nil
  end

  def find_categories
    @categories = Category.all
  end

  def authenticate_admin!
    authenticate_user!

    unless current_user.admin?
      redirect_to root_path, alert: 'You are not allowed to do that'
    end
  end
end
