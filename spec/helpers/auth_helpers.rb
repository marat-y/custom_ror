module AuthHelpers
  SIGN_UP_PATH = '/users/sign_up'.freeze
  SIGN_IN_PATH = '/users/sign_in'.freeze

  def sign_up_user(email:, password:)
    visit SIGN_UP_PATH
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up'
    expect(page).to have_text 'Welcome! You have signed up successfully.'
  end

  def sign_in_user(email:, password:)
    visit SIGN_IN_PATH
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
    expect(page).to have_text 'Signed in successfully.'
  end

  def sign_out
    click_link 'Sign out'
    expect(page).to have_text 'You need to sign in or sign up before continuing.'
  end
end
