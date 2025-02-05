require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe TutorsController, type: :controller do
    let!(:tutor) { create(:tutor) }
    let(:valid_attributes) { attributes_for(:tutor) }
    let(:invalid_attributes) { { name: '', surname: '', tutor_specialization: nil, hourly_price: nil } }

    describe 'GET #index' do
        it 'returns a success response' do
            get :index
            expect(response).to be_successful
        end

    it 'filters tutors by specialization' do
        get :index, params: { specialization: tutor.tutor_specialization }
        expect(assigns(:tutors)).to include(tutor)
        end
    end

    describe 'GET #show' do
        context 'when the tutor exists' do
            it 'returns a success response' do
                get :show, params: { id: tutor.id }
                expect(response).to be_successful
            end
        end

        context 'when the tutor does not exist' do
            it 'raises an ActiveRecord::RecordNotFound error' do
            expect {
                get :show, params: { id: '99999' } # Assuming 99999 is a non-existent ID
            }.to raise_error(ActiveRecord::RecordNotFound)
            end
        end
    end

    describe 'GET #new' do
        it 'returns a success response' do
            get :new
            expect(response).to be_successful
        end
    end

    describe 'POST #create' do
        context 'with valid parameters' do
            it 'creates a new tutor' do
            puts valid_attributes.inspect
            expect {
                post :create, params: { tutor: valid_attributes }
            }.to change(Tutor, :count).by(1)
        end

            it 'redirects to the created tutor' do
                post :create, params: { tutor: valid_attributes }
                expect(response).to redirect_to(Tutor.last)
                end
        end

        context 'with invalid parameters' do
            it 'does not create a new tutor when name is empty' do
                expect {
                    post :create, params: { tutor: valid_attributes.merge(name: '') }
                }.to_not change(Tutor, :count)
            end
        
            it 'does not create a new tutor when surname is empty' do
                expect {
                    post :create, params: { tutor: valid_attributes.merge(surname: '') }
                }.to_not change(Tutor, :count)
            end
        
            it 'does not create a new tutor when specialization is empty' do
                expect {
                    post :create, params: { tutor: valid_attributes.merge(tutor_specialization: '') }
                }.to_not change(Tutor, :count)
            end
        
            it 'does not create a new tutor when hourly price is empty' do
                expect {
                    post :create, params: { tutor: valid_attributes.merge(hourly_price: nil) }
                }.to_not change(Tutor, :count)
            end
        
            it 'does not create a new tutor when name exceeds maximum length' do
                long_name = 'A' * 41
                expect {
                    post :create, params: { tutor: valid_attributes.merge(name: long_name) }
                }.to_not change(Tutor, :count)
            end
        
            it 'does not create a new tutor when surname exceeds maximum length' do
                long_surname = 'B' * 41
                expect {
                    post :create, params: { tutor: valid_attributes.merge(surname: long_surname) }
                }.to_not change(Tutor, :count)
            end
        
            it 'does not create a new tutor when specialization exceeds maximum length' do
                long_specialization = 'C' * 41
                expect {
                    post :create, params: { tutor: valid_attributes.merge(tutor_specialization: long_specialization) }
                }.to_not change(Tutor, :count)
            end
        
            it 'does not create a new tutor when hourly price is negative' do
                expect {
                    post :create, params: { tutor: valid_attributes.merge(hourly_price: -5) }
                }.to_not change(Tutor, :count)
            end
        
            it 'does not create a new tutor when hourly price is zero' do
                expect {
                    post :create, params: { tutor: valid_attributes.merge(hourly_price: 0) }
                }.to_not change(Tutor, :count)
            end
        
            it 'does not create a new tutor when hourly price exceeds limit' do
                expect {
                    post :create, params: { tutor: valid_attributes.merge(hourly_price: 10_000) }
                }.to_not change(Tutor, :count)
            end
        
            it 'does not create a new tutor when specialization is not unique for the same name and surname' do
                create(:tutor, name: "John", surname: "Doe", tutor_specialization: "Math")
                expect {
                    post :create, params: { tutor: valid_attributes.merge(name: "John", surname: "Doe", tutor_specialization: "Math") }
                }.to_not change(Tutor, :count)
            end
        
            it 'renders the new template with unprocessable entity status' do
                post :create, params: { tutor: invalid_attributes }
                expect(response).to have_http_status(:unprocessable_entity)
                expect(response).to render_template(:new)
            end
        end   
    end

    describe 'PATCH #update' do
        context 'with valid parameters' do
            it 'updates the requested tutor' do
                patch :update, params: { id: tutor.id, tutor: { name: 'Updated Name' } }
                tutor.reload
                expect(tutor.name).to eq('Updated Name')
            end
        end

        context 'with invalid parameters' do
            it 'does not update the tutor when name is empty' do
                patch :update, params: { id: tutor.id, tutor: { name: '' } }
                tutor.reload
                expect(tutor.name).not_to eq('')
            end
        
            it 'does not update the tutor when surname is empty' do
                patch :update, params: { id: tutor.id, tutor: { surname: '' } }
                tutor.reload
                expect(tutor.surname).not_to eq('')
            end
        
            it 'does not update the tutor when specialization is empty' do
                patch :update, params: { id: tutor.id, tutor: { tutor_specialization: '' } }
                tutor.reload
                expect(tutor.tutor_specialization).not_to eq('')
            end
        
            it 'does not update the tutor when hourly price is empty' do
                patch :update, params: { id: tutor.id, tutor: { hourly_price: nil } }
                tutor.reload
                expect(tutor.hourly_price).not_to be_nil
            end
        
            it 'does not update the tutor when name exceeds maximum length' do
                long_name = 'A' * 41
                patch :update, params: { id: tutor.id, tutor: { name: long_name } }
                tutor.reload
                expect(tutor.name).not_to eq(long_name)
            end
        
            it 'does not update the tutor when surname exceeds maximum length' do
                long_surname = 'B' * 41
                patch :update, params: { id: tutor.id, tutor: { surname: long_surname } }
                tutor.reload
                expect(tutor.surname).not_to eq(long_surname)
            end
        
            it 'does not update the tutor when specialization exceeds maximum length' do
                long_specialization = 'C' * 41
                patch :update, params: { id: tutor.id, tutor: { tutor_specialization: long_specialization } }
                tutor.reload
                expect(tutor.tutor_specialization).not_to eq(long_specialization)
            end
        
            it 'does not update the tutor when hourly price is negative' do
                patch :update, params: { id: tutor.id, tutor: { hourly_price: -5 } }
                tutor.reload
                expect(tutor.hourly_price).not_to eq(-5)
            end
        
            it 'does not update the tutor when hourly price is zero' do
                patch :update, params: { id: tutor.id, tutor: { hourly_price: 0 } }
                tutor.reload
                expect(tutor.hourly_price).not_to eq(0)
            end
        
            it 'does not update the tutor when hourly price exceeds limit' do
                patch :update, params: { id: tutor.id, tutor: { hourly_price: 10_000 } }
                tutor.reload
                expect(tutor.hourly_price).not_to eq(10_000)
            end
        
            it 'renders the edit template with unprocessable entity status' do
                patch :update, params: { id: tutor.id, tutor: { name: '' } }
                expect(response).to have_http_status(:unprocessable_entity)
                expect(response).to render_template(:edit)
            end
        end      
    end

    describe 'DELETE #destroy' do
        it 'destroys the requested tutor' do
            expect {
                delete :destroy, params: { id: tutor.id }
            }.to change(Tutor, :count).by(-1)
        end

        it 'redirects to tutors list' do
            delete :destroy, params: { id: tutor.id }
            expect(response).to redirect_to(tutors_path)
        end
    end
end

