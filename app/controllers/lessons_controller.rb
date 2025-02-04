class LessonsController < ApplicationController
  before_action :set_tutor
  before_action :set_lesson, only: [:edit, :update, :destroy]

  def new
    @lesson = @tutor.lessons.build
  end

  def create
    @lesson = @tutor.lessons.build(lesson_params)
  
    if @lesson.lesson_date.present? && @lesson.lesson_date < Date.today
      @lesson.errors.add(:lesson_date, "cannot be in the past.")
      render :new, status: :unprocessable_entity
    elsif @tutor.lessons.exists?(lesson_date: @lesson.lesson_date)
      @lesson.errors.add(:lesson_date, "A lesson already exists on this date.")
      render :new, status: :unprocessable_entity
    elsif @lesson.save
      redirect_to tutor_path(@tutor), notice: "Lesson successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if lesson_params[:lesson_date].present? && lesson_params[:lesson_date].to_date < Date.today
      render :edit, status: :unprocessable_entity
    elsif @tutor.lessons.where(lesson_date: lesson_params[:lesson_date]).where.not(id: @lesson.id).exists?
      flash[:alert] = "A lesson already exists for this tutor on this date."
      render :edit, status: :unprocessable_entity
    elsif @lesson.update(lesson_params)
      redirect_to tutor_path(@tutor), notice: "Lesson successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson.destroy
    redirect_to tutor_path(@tutor), notice: "Lesson successfully deleted."
  end

  private

  def set_tutor
    @tutor = Tutor.find(params[:tutor_id])
  end

  def set_lesson
    @lesson = @tutor.lessons.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:lesson_date)
  end  
end
