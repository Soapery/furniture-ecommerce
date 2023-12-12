class HomeController < ApplicationController
  def index
    if params[:search]
      @products = Product.where("name LIKE ?", "%#{params[:search]}%").paginate(page: params[:page], per_page: 40)
    else
      @products = Product.paginate(page: params[:page], per_page: 40)
    end
  end
end
