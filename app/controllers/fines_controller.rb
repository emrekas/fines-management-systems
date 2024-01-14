class FinesController < ApplicationController
  def index
    @fines = Fine.all
  end

  def new
    @fine = Fine.new
  end

  def create
    @fine = Fine.new(fine_params)
    @fine.penalty_amount = 0
    if @fine.save
      redirect_to fines_path
    else
      render 'new'
    end
  end

  def edit
    @fine = Fine.find(params[:id])
  end

  def update
    @fine = Fine.find(params[:id])
    if @fine.update(fine_params)
      redirect_to fines_path
    else
      render 'edit'
    end
  end

  def destroy
    @fine = Fine.find(params[:id])
    @fine.destroy
    redirect_to fines_path
  end

  private
    def fine_params
      params.require(:fine).permit(:amount, :reason, :place, :time_of_issue, :payment_status, :penalty_amount, :vehicle_id)
    end
end
