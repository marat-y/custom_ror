require 'rails_helper'

describe Event, type: :feature do
  include EventHelpers
  include NavigationHelpers

  let(:user) { create :user }
  let(:admin) { create :admin }

  before do
    as_user(user) do
      create_event(title: 'Foo')
    end
  end

  it 'provides events CRUD' do
    as_admin(admin) do
      update_admin_event('Foo', title: 'Bar')

      # list events
      visit_admin_events
      expect(page).to have_text 'Bar'

      destroy_admin_event('Bar')
      visit_admin_events
      expect(page).not_to have_text 'Bar'
    end
  end
end
