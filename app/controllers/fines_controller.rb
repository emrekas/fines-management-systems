class FinesController < ApplicationController
  load_and_authorize_resource
  def index
    if current_user.role == 'individual'
      @fines = Fine.includes(:vehicle).where(vehicles: {user_id: current_user.id})
    else
      @fines = Fine.all
    end
  end

  def show
    if current_user.role == 'individual'
      @fine = Fine.includes(:vehicle).where(vehicles:{user_id: current_user.id}).find(params[:id])
    else
      @fine = Fine.find(params[:id])
    end
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

  def pay
    @fine = Fine.find(params[:id])
    @fine.payment_status = 'paid'
    if (Time.now - @fine.time_of_issue) <= 5.days
      @fine.amount *= 0.5
    else
      days_overdue = (Time.now - @fine.time_of_issue).to_i / 1.day
      @fine.amount = (@fine.amount * 0.02 * days_overdue)
    end
    @fine.save
    redirect_to fines_path
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
