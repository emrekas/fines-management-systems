class VehiclesController < ApplicationController
def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.user_id = session[:user_id]
    if @vehicle.save
      redirect_to vehicles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.update(vehicle_params)
      redirect_to vehicles_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    vehicle = Vehicle.find(params[:id])
    vehicle.destroy
    redirect_to vehicles_path
  end

  private
    def vehicle_params
      params.require(:vehicle).permit(:plate_number, :vehicle_type, :make, :year_of_production, :user_id)
    end
end
