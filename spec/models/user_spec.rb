require 'rails_helper'
require 'cancan/matchers'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'abilities' do
    subject(:ability) { Ability.new(user) }

    let(:user) { create :user }

    it { is_expected.to be_able_to(:read, Event.new) }

    context 'when owns event' do
      let(:event) { create(:event, user: user) }

      it { is_expected.to be_able_to(:update, event) }
      it { is_expected.to be_able_to(:destroy, event) }
    end

    context 'when does not own event' do
      let(:user2) { create :user }
      let(:event) { create(:event, user: user2) }

      it { is_expected.not_to be_able_to(:update, event) }
      it { is_expected.not_to be_able_to(:destroy, event) }
    end
  end
end
