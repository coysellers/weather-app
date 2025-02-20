class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    
    if @location.save
      respond_to do |format|
        format.turbo_stream { redirect_to locations_path, notice: 'Location was successfully added' }
        format.html { redirect_to locations_path, notice: 'Location was successfully added' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @location = Location.find(params[:id])
    
    @forecast = @location.seven_day_forecast
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.turbo_stream { redirect_to locations_path, notice: 'Location was successfully removed' }
      format.html { redirect_to locations_path, notice: 'Location was successfully removed' }
    end
  end

  private

  def location_params
    params.require(:location).permit(:address, :ip_address)
  end
end
