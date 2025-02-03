module TutorsFilterable
    extend ActiveSupport::Concern
  
    included do
      before_action :load_specializations, only: :index
      before_action :load_tutors, only: :index
    end
  
    private
  
    def load_specializations
      @specializations = Tutor.select(:tutor_specialization).distinct.pluck(:tutor_specialization)
    end
  
    def load_tutors
      @tutors = Tutor.left_joins(:lessons)
                     .group(:id)
                     .order('COUNT(lessons.id) DESC')
      apply_filters
    end
  
    def apply_filters
      filter_tutors_by_query
      filter_tutors_by_specialization
      filter_tutors_by_date
    end
  
    def filter_tutors_by_query
      return unless params[:query].present?
  
      @tutors = @tutors.where("name ILIKE :prefix OR surname ILIKE :prefix", prefix: "#{params[:query]}%")
    end
  
    def filter_tutors_by_specialization
      return unless params[:specialization].present? && params[:specialization] != "All"
  
      @tutors = @tutors.where(tutor_specialization: params[:specialization])
    end
  
    def filter_tutors_by_date
      return unless params[:date].present?
  
      selected_date = Date.parse(params[:date]) rescue nil
      return unless selected_date
  
      @tutors = @tutors.where.not(id: Lesson.where(lesson_date: selected_date).select(:tutor_id))
    end
  end
  