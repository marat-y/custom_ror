require 'rails_helper'

describe Event, type: :feature do
  include EventHelpers
  include NavigationHelpers

  it 'provides CRUD' do
    create_event(title: 'Foo')
    update_event('Foo', title: 'Bar')

    # list events
    visit '/events'
    expect(page).to have_text 'Bar'

    destroy_event('Bar')
    visit '/events'
    expect(page).not_to have_text 'Bar'
  end
end
