class HomeController < ApplicationController
  def index
    @products = if params[:search]
                  Product.where("name LIKE ?", "%#{params[:search]}%").page(params[:page]).per(40)
                else
                  Product.all.page(params[:page]).per(40)
                end
  end
end
