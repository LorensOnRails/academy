class Admin::LessonsController < ApplicationController
 before_action :authenticate_admin!

 layout "admin"

 def show
  @lesson = Lesson.find(params[:id])
 end

 def index
  @lessons = Lesson.all
 end

 def new
  @workshop = Workshop.find(params[:workshop_id])
  @lesson = Lesson.new
 end

 def edit
  @workshop = Workshop.find(params[:workshop_id])
  @lesson = Lesson.find(params[:id])
 end

 def update
  @lesson = Lesson.find(params[:id])
  if @lesson.update_attributes(admin_lesson_params)
   flash[:notice] = 'Changes updated successfully!'
   redirect_back(fallback_location: root_path)
  else
   flash[:notice] = 'Could not update, Please try again'
   render :edit, alert: "Could not update, Please try again"
  end
 end

 def create
  @workshop = Workshop.find(params[:workshop_id])
  @lesson = Lesson.new(admin_lesson_params)

  respond_to do |format|
   if @lesson.save
    format.html { redirect_to edit_admin_workshop_url(@workshop), notice: 'Lesson was successfully created.' }
    format.json { render json: @lesson, status: :created, location: [:admin,@lesson] }
   else
    format.html { render action: "new" }
    format.json { render json: @lesson.errors, status: :unprocessable_entity }
   end
  end
 end

 def destroy
  @workshop = Workshop.find(params[:workshop_id])
  @lesson = Lesson.find(params[:id])
  @lesson.destroy
  redirect_to edit_admin_workshop_url(@workshop), notice: "Successfully deleted the lesson"
 end

 private

 def set_lesson
  @lesson = current_lesson
 end

 def admin_lesson_params
  params.require(:lesson).permit(:title, :description, :account_id, :workshop_id, :slug, :video, :order, :video, :remove_video)
 end

end