module Lessons
    module LessonSetup
      extend ActiveSupport::Concern
  
      included do
        before_action :set_tutor
        before_action :set_lesson, only: [:edit, :update, :destroy]
      end
  
      private
  
      def set_tutor
        @tutor = Tutor.find(params[:tutor_id])
      end
  
      def set_lesson
        @lesson = @tutor.lessons.find(params[:id])
      end
    end
  end
  