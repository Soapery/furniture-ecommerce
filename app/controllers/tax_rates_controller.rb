class TaxRatesController < ApplicationController

  def index
    @provinces = Province.all # Fetch all provinces
  end


def edit
  @province = Province.find(params[:id]) # Find the province by ID
end

def update
  @province = Province.find(params[:id]) # Find the province by ID
  if @province.update(province_params)
    # Successfully updated, redirect to index or show page
    redirect_to tax_rates_path, notice: 'Tax rates updated successfully.'
  else
    # Error occurred, render edit form again
    render :edit
  end
end

private

def province_params
  params.require(:province).permit(:gst, :pst, :hst) # Permit the necessary parameters for update
end

end
