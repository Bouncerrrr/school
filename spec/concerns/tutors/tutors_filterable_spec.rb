require 'rails_helper'

RSpec.describe Tutors::TutorsFilterable, type: :controller do
  controller(ApplicationController) do
    include Tutors::TutorsFilterable

    def index
      head :ok
    end
  end

  let!(:tutor1) { create(:tutor, name: 'Alice', surname: 'Smith', tutor_specialization: 'Math') }
  let!(:tutor2) { create(:tutor, name: 'Bob', surname: 'Johnson', tutor_specialization: 'Science') }

  before do
    controller.instance_variable_set(:@tutors, Tutor.all)
  end

  describe '#filter_tutors_by_query' do
    it 'filters by name' do
      get :index, params: { query: 'Alice' }
      filtered_tutors = assigns(:tutors).pluck(:name)
      expect(filtered_tutors).to include('Alice')
      expect(filtered_tutors).not_to include('Bob')
    end
  end

  describe '#filter_tutors_by_specialization' do
    it 'filters by specialization' do
      get :index, params: { specialization: 'Math' }
      filtered_tutors = assigns(:tutors).pluck(:tutor_specialization)
      expect(filtered_tutors).to include('Math')
      expect(filtered_tutors).not_to include('Science')
    end
  end

  describe '#filter_tutors_by_date' do
    it 'filters tutors with lessons on a given date' do
      lesson = create(:lesson, tutor: tutor1, lesson_date: '2025-02-10')
      get :index, params: { date: '2025-02-10' }
      filtered_tutors = assigns(:tutors).pluck(:name)
      expect(filtered_tutors).not_to include('Alice') # Should be filtered out
    end
  end
end
