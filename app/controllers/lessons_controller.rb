class LessonsController < ApplicationController
    before_action :set_tutor
  before_action :set_lesson, only: %i[edit update destroy]

  def index
   
  end

  def new
    
  end

  def create
    
  end

  def edit
  end

  def update
   
  end

  def destroy

  end

  private

  def set_tutor
    @tutor = Tutor.find(params[:tutor_id])
  end

  def set_lesson
    @lesson = @tutor.lessons.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:date, :day)
  end
end
