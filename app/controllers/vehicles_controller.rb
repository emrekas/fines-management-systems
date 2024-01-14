class VehiclesController < ApplicationController
  load_and_authorize_resource
  def index
    if current_user.role == 'individual'
      @vehicles = Vehicle.where(user_id: current_user.id).includes(:fines)
    else
      @vehicles = Vehicle.includes(:fines).all
    end
  end

  def new
    @vehicle = Vehicle.new
  end

  def show
    @vehicle = Vehicle.find(params[:id])
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
