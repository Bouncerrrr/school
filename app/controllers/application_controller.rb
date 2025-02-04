class ApplicationController < ActionController::Base
    before_action :set_specializations

    private

    def set_specializations
        @specializations = Tutor.distinct.pluck(:tutor_specialization) # Fetch unique specializations
    end
end
