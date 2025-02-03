class TutorsController < ApplicationController
  include TutorsFilterable

  before_action :set_tutor, only: [:show, :edit, :update, :destroy]

  def index; end

  def show
    load_tutor_with_lessons
  end

  def new
    @tutor = Tutor.new
  end

  def create
    @tutor = Tutor.new(tutor_params)
    if @tutor.save
      redirect_to @tutor, notice: 'Tutor was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @tutor.update(tutor_params)
      redirect_to @tutor, notice: 'Tutor was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tutor.destroy
    redirect_to tutors_path, notice: 'Tutor was successfully deleted.'
  end

  private

  def set_tutor
    @tutor = Tutor.find(params[:id])
  end

  def tutor_params
    params.require(:tutor).permit(:name, :surname, :tutor_specialization, :hourly_price)
  end

  def load_tutor_with_lessons
    @tutor = Tutor.find(params[:id])
    @lessons = @tutor.lessons.order(lesson_date: :asc)
  end
end
