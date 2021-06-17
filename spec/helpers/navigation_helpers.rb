module NavigationHelpers
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
