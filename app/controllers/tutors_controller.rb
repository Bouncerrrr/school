class TutorsController < ApplicationController
  include TutorsFilterable

  before_action :set_tutor, only: [:show, :edit, :update, :destroy]
  before_action :set_specializations, only: [:index, :new, :edit]

  def index
    @tutors

    if params[:specialization].present? && params[:specialization] != "All"
      @tutors = @tutors.where(tutor_specialization: params[:specialization])
    end
  end

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
    if @tutor.destroy
      flash[:notice] = 'Tutor was successfully deleted.'
    else
      flash[:alert] = 'Tutor could not be deleted.'
    end
    redirect_to tutors_path
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

  def set_specializations
    @specializations = Tutor.distinct.pluck(:tutor_specialization)
  end

end
