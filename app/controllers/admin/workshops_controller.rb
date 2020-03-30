class Admin::WorkshopsController < ApplicationController
  before_action :authenticate_admin!

  layout "admin"

  def show
    @workshop = Workshop.find(params[:id])
  end

  def index
    @workshops = Workshop.all
  end

  def new
    @workshop = Workshop.new
  end

  def edit
    @workshop = Workshop.find(params[:id])
  end

  def update
    @workshop = Workshop.find(params[:id])
    if @workshop.update_attributes(admin_workshop_params)
      flash[:notice] = 'Changes updated successfully!'
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = 'Could not update, Please try again'
      render :edit, alert: "Could not update, Please try again"
    end
  end

  def create
    @workshop = Workshop.new(admin_workshop_params)

    respond_to do |format|
      if @workshop.save
        format.html { redirect_to admin_workshops_url, notice: 'Workshop was successfully created.' }
        format.json { render json: @workshop, status: :created, location: [:admin,@workshop] }
      else
        format.html { render action: "new" }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @workshop.destroy
    redirect_to root_url, notice: "Successfully deleted the workshop"
  end

  private

  def set_workshop
    @workshop = current_workshop
  end

  def admin_workshop_params
    params.require(:workshop).permit(:title, :subtitle, :description, :account_id, :difficulty, :category, :language, :requirements, :outcomes, :cost, :discount, :image, :remove_image)
  end

end