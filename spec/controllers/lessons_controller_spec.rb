require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  let!(:tutor) { create(:tutor) }
  let!(:lesson) { create(:lesson, tutor: tutor, lesson_date: Date.today + 1) }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { tutor_id: tutor.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new lesson' do
        expect {
          post :create, params: { tutor_id: tutor.id, lesson: { lesson_date: Date.today + 2 } }
        }.to change(Lesson, :count).by(1)
      end

      it 'redirects to tutor show page after successful creation' do
        post :create, params: { tutor_id: tutor.id, lesson: { lesson_date: Date.today + 2 } }
        expect(response).to redirect_to(tutor_path(tutor))
        expect(flash[:notice]).to eq("Lesson successfully created.")
      end
    end

    context 'with invalid parameters' do
      it 'does not create a lesson with a past date' do
        expect {
          post :create, params: { tutor_id: tutor.id, lesson: { lesson_date: Date.yesterday } }
        }.not_to change(Lesson, :count)
      end

      it 'does not create a duplicate lesson on the same date' do
        expect {
          post :create, params: { tutor_id: tutor.id, lesson: { lesson_date: lesson.lesson_date } }
        }.not_to change(Lesson, :count)
      end

      it 'renders the new template with unprocessable entity status' do
        post :create, params: { tutor_id: tutor.id, lesson: { lesson_date: Date.yesterday } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { tutor_id: tutor.id, id: lesson.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the lesson successfully' do
        new_date = Date.today + 3
        patch :update, params: { tutor_id: tutor.id, id: lesson.id, lesson: { lesson_date: new_date } }
        lesson.reload
        expect(lesson.lesson_date).to eq(new_date)
      end

      it 'redirects to tutor show page after update' do
        patch :update, params: { tutor_id: tutor.id, id: lesson.id, lesson: { lesson_date: Date.today + 3 } }
        expect(response).to redirect_to(tutor_path(tutor))
        expect(flash[:notice]).to eq("Lesson successfully updated.")
      end
    end

    context 'with invalid parameters' do
      it 'does not update the lesson if the date is in the past' do
        patch :update, params: { tutor_id: tutor.id, id: lesson.id, lesson: { lesson_date: Date.yesterday } }
        lesson.reload
        expect(lesson.lesson_date).not_to eq(Date.yesterday)
      end

      it 'does not update the lesson if the new date is already taken' do
        existing_lesson = create(:lesson, tutor: tutor, lesson_date: Date.today + 4)
        patch :update, params: { tutor_id: tutor.id, id: lesson.id, lesson: { lesson_date: existing_lesson.lesson_date } }
        lesson.reload
        expect(lesson.lesson_date).not_to eq(existing_lesson.lesson_date)
      end

      it 'renders the edit template with unprocessable entity status' do
        patch :update, params: { tutor_id: tutor.id, id: lesson.id, lesson: { lesson_date: Date.yesterday } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested lesson' do
      expect {
        delete :destroy, params: { tutor_id: tutor.id, id: lesson.id }
      }.to change(Lesson, :count).by(-1)
    end

    it 'redirects to tutor show page after deletion' do
      delete :destroy, params: { tutor_id: tutor.id, id: lesson.id }
      expect(response).to redirect_to(tutor_path(tutor))
      expect(flash[:notice]).to eq("Lesson successfully deleted.")
    end
  end
end
