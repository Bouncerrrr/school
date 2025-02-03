class TutorsController < ApplicationController
  before_action :set_tutor, only: [:show, :edit, :update, :destroy]
  
  def index
    @specializations = Tutor.select(:tutor_specialization).distinct.pluck(:tutor_specialization)
  
    @tutors = Tutor.left_joins(:lessons)
                   .group(:id)
                   .order('COUNT(lessons.id) DESC')
  
    if params[:query].present?
      @tutors = @tutors.where("name ILIKE :prefix OR surname ILIKE :prefix", prefix: "#{params[:query]}%")
    end
  
    if params[:specialization].present? && params[:specialization] != "All"
      @tutors = @tutors.where(tutor_specialization: params[:specialization])
    end
  
    if params[:date].present?
      selected_date = Date.parse(params[:date]) rescue nil
      if selected_date
        @tutors = @tutors.where.not(id: Lesson.where(lesson_date: selected_date).select(:tutor_id))
      end
    end
  end
  
  def show
    @tutor = Tutor.find(params[:id])
    @lessons = @tutor.lessons.order(lesson_date: :asc)
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

  def edit
    @tutor
  end

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
end
