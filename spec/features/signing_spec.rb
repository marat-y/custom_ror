require 'rails_helper'

describe 'Authorization', type: :feature do
  include AuthHelpers

  before do
    sign_up_user(email: 'foobar@example.com', password: '123qwe')
    sign_out
  end

  it 'can sign in' do
    sign_in_user(email: 'foobar@example.com', password: '123qwe')
    expect(page).to have_text 'Signed in successfully.'
  end

  it 'can sign out' do
    sign_in_user(email: 'foobar@example.com', password: '123qwe')
    click_link 'Sign out'
    expect(page).to have_text 'You need to sign in or sign up before continuing.'
  end
end
