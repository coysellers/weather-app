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
      redirect_to locations_path, notice: 'Location was successfully added'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @location = Location.find(params[:id])
    
    begin
      @forecast = @location.seven_day_forecast
    rescue StandardError => e
      redirect_to locations_path, alert: "Error fetching forecast: #{e.message}"
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to locations_path, notice: 'Location was successfully removed'
  end

  private

  def location_params
    params.require(:location).permit(:address, :ip_address)
  end
end
