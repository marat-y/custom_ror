require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Admin, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'abilities' do
    subject(:ability) { AdminAbility.new(admin) }

    let(:admin) { create :admin }
    let(:event) { create :event }

    it { is_expected.to be_able_to(:read, event) }
    it { is_expected.to be_able_to(:update, event) }
    it { is_expected.to be_able_to(:destroy, event) }
    it { is_expected.not_to be_able_to(:create, event) }
  end
end
