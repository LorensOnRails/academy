class LessonsController < ApplicationController
 before_action :authenticate_admin!, only: [:sort]
 before_action :authenticate_account!, only: [:show]

 def show
  @lesson = Lesson.find(params[:id])
 end

 def sort
  params[:lesson].each_with_index do |id, index|
   Lesson.where(id: id).update_all(order: index + 1)
  end
  head :ok
 end

 private

 def set_lesson
  @lesson = current_lesson
 end

 def lesson_params
  params.require(:lesson).permit(:title, :description, :account_id, :workshop_id, :slug, :video, :order, :video, :remove_video)
 end

end