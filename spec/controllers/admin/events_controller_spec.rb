require 'rails_helper'

RSpec.describe Admin::EventsController do
  context 'when admin signs in' do
    let(:admin) { create :admin }

    before do
      sign_in admin
    end

    describe 'GET index' do
      it 'assigns @events' do
        event = create(:event)
        get :index
        expect(assigns(:events)).to eq([event])
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

    describe 'GET show' do
      let(:event) { create :event }

      it 'assigns @event' do
        get :show, params: { id: event.id }
        expect(assigns(:event)).to eq(event)
      end

      it 'renders the show template' do
        get :show, params: { id: event.id }
        expect(response).to render_template('show')
      end
    end

    describe 'GET edit' do
      let(:event) { create :event }

      it 'assigns @event' do
        get :edit, params: { id: event.id }
        expect(assigns(:event)).to eq(event)
      end

      it 'renders the edit template' do
        get :edit, params: { id: event.id }
        expect(response).to render_template('edit')
      end
    end

    describe 'PATCH update' do
      let(:event) { create :event }

      it 'updates event' do
        patch :update, params: { id: event.id, event: { title: 'Foobar' } }
        expect(event.reload.title).to eq 'Foobar'
      end

      it 'redirects to event' do
        patch :update, params: { id: event.id, event: { title: 'Foobar' } }
        expect(response).to redirect_to [:admin, event]
      end
    end

    describe 'DELETE destroy' do
      let!(:event) { create :event }

      it 'deletes event' do
        expect do
          delete :destroy, params: { id: event.id }
        end.to change(Event, :count).by(-1)
      end

      it 'redirects to events' do
        delete :destroy, params: { id: event.id }
        expect(response).to redirect_to admin_events_path
      end
    end
  end

  context 'when regular user signs in' do
    let(:user) { create :user }

    before do
      sign_in user
    end

    describe 'GET index' do
      it 'restricts access' do
        get :index
        expect(response).to redirect_to new_admin_session_path
      end
    end

    describe 'GET show' do
      let(:event) { create :event }

      it 'restricts access' do
        get :show, params: { id: event.id }
        expect(response).to redirect_to new_admin_session_path
      end
    end

    describe 'GET edit' do
      let(:event) { create :event }

      it 'restricts access' do
        get :edit, params: { id: event.id }
        expect(response).to redirect_to new_admin_session_path
      end
    end

    describe 'PATCH update' do
      let(:event) { create :event }

      it 'restricts access' do
        patch :update, params: { id: event.id, event: { title: 'Foobar' } }
        expect(event.reload.title).not_to eq 'Foobar'
        expect(response).to redirect_to new_admin_session_path
      end
    end

    describe 'DELETE destroy' do
      let!(:event) { create :event }

      it 'restricts access' do
        expect do
          delete :destroy, params: { id: event.id }
        end.not_to change(Event, :count)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
