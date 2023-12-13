class HomeController < ApplicationController
  def index
    if params[:search]
      @products = Product.where("name LIKE ?", "%#{params[:search]}%").page(params[:page]).per(40)
    else
      @products = Product.all.page(params[:page]).per(40)
    end
  end
end
