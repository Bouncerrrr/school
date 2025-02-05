module Lessons
    module LessonValidation
      extend ActiveSupport::Concern
  
      private
  
      def lesson_invalid?(lesson)
        if lesson.lesson_date.present? && lesson.lesson_date < Date.today
          lesson.errors.add(:lesson_date, "cannot be in the past.")
          return true
        elsif @tutor.lessons.exists?(lesson_date: lesson.lesson_date)
          lesson.errors.add(:lesson_date, "A lesson already exists on this date.")
          return true
        end
        false
      end
  
      def lesson_update_invalid?(params)
        if params[:lesson_date].present? && params[:lesson_date].to_date < Date.today
          flash[:alert] = "Lesson date cannot be in the past."
          return true
        elsif @tutor.lessons.where(lesson_date: params[:lesson_date]).where.not(id: @lesson.id).exists?
          flash[:alert] = "A lesson already exists for this tutor on this date."
          return true
        end
        false
      end
    end
  end
  