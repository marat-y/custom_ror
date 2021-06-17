require 'rails_helper'

describe Event, type: :feature do
  include EventHelpers
  include NavigationHelpers

  let(:user) { create :user }

  it 'provides CRUD' do
    as_user(user) do
      create_event(title: 'Foo')
      update_event('Foo', title: 'Bar')

      # list events
      visit_events
      expect(page).to have_text 'Bar'

      destroy_event('Bar')
      visit_events
      expect(page).not_to have_text 'Bar'
    end
  end
end
