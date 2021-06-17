module EventHelpers
  def create_event(title:)
    visit '/events/new'
    fill_in 'Title', with: title
    click_button 'Save'

    expect(page).to have_text 'Event was successfully created.'
    expect(page).to have_text "Event #{title}"
  end

  def update_event(event, title: nil)
    visit '/events'
    within_row event do
      click_link 'Edit'
    end
    fill_in 'Title', with: title if title
    click_button 'Save'

    expect(page).to have_text 'Event was successfully updated.'
    expect(page).to have_text "Event #{title}" if title
  end

  def destroy_event(event)
    visit '/events'
    within_row event do
      accept_confirm do
        click_link 'Destroy'
      end
    end

    expect(page).to have_text 'Event was successfully destroyed.'
  end
end
