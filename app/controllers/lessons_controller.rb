class LessonsController < ApplicationController
  include Lessons::LessonSetup
  include Lessons::LessonValidation

  def new
    @lesson = @tutor.lessons.build
  end

  def create
    @lesson = @tutor.lessons.build(lesson_params)

    if lesson_invalid?(@lesson)
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
    if lesson_update_invalid?(lesson_params)
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

  def lesson_params
    params.require(:lesson).permit(:lesson_date)
  end
end
