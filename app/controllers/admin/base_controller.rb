class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def current_ability
    AdminAbility.new(current_admin)
  end
end
