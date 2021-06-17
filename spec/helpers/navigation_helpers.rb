module NavigationHelpers
  def as_user(user)
    sign_in user
    result = yield
    sign_out user
    result
  end

  def visit_events
    visit '/events'
  end

  def find_proper_row(text)
    cell = find(:css, 'td', text: text)
    cell.find(:xpath, './parent::tr')
  end

  def within_row(text)
    within(find_proper_row(text)) do
      yield
    end
  end
end
