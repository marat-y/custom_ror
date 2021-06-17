require 'rails_helper'

RSpec.describe EventsController do
  let(:user) { create :user }

  describe 'GET index' do
    before do
      sign_in user
    end

    it 'assigns @events' do
      event = create(:event, user: user)
      get :index
      expect(assigns(:events)).to eq([event])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    before do
      sign_in user
    end

    let(:event) { create :event, user: user }

    it 'assigns @event' do
      get :show, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end

    it 'renders the show template' do
      get :show, params: { id: event.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET new' do
    before do
      sign_in user
    end

    it 'assigns @event' do
      get :new
      expect(assigns(:event)).to be_an(Event)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET edit' do
    let(:event) { create :event, user: user }
    let(:user2) { create :user }

    it 'assigns @event' do
      sign_in user
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end

    it 'renders the edit template' do
      sign_in user
      get :edit, params: { id: event.id }
      expect(response).to render_template('edit')
    end

    it 'restricts editing non-owned events' do
      sign_in user2

      expect { get :edit, params: { id: event.id } }.to raise_error CanCan::AccessDenied
    end
  end

  describe 'POST create' do
    let(:event_attributes) { attributes_for :event }

    it 'creates event' do
      expect do
        post :create, params: { event: event_attributes }
      end.to change(Event, :count).by 1
    end

    it 'validates event' do
      expect do
        post :create, params: { event: { title: '' } }
      end.not_to change(Event, :count)
    end

    it 'redirects to event' do
      post :create, params: { event: event_attributes }
      expect(response).to redirect_to event_path(assigns(:event).id)
    end
  end

  describe 'PATCH update' do
    let(:event) { create :event, user: user }

    it 'updates event' do
      patch :update, params: { id: event.id, event: { title: 'Foobar' } }
      expect(event.reload.title).to eq 'Foobar'
    end

    it 'redirects to event' do
      patch :update, params: { id: event.id, event: { title: 'Foobar' } }
      expect(response).to redirect_to event
    end

    it 'restricts updating non-owned events' do
      user2 = create :user
      sign_in user2

      expect { patch :update, params: { id: event.id, event: { title: 'Foobar' } } }.to raise_error CanCan::AccessDenied
    end
  end

  describe 'DELETE destroy' do
    let!(:event) { create :event, user: user }

    it 'deletes event' do
      expect do
        delete :destroy, params: { id: event.id }
      end.to change(Event, :count).by(-1)
    end

    it 'redirects to events' do
      delete :destroy, params: { id: event.id }
      expect(response).to redirect_to events_path
    end

    it 'restricts destroying non-owned events' do
      user2 = create :user
      sign_in user2

      expect { delete :destroy, params: { id: event.id } }.to raise_error CanCan::AccessDenied
    end
  end
end
