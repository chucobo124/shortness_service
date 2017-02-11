require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let(:shortener) { create(:shortener, user: user) }

  describe 'shortener' do
    subject { User.first }
    it { is_expected.to eq shortener.user }
  end
  describe 'save_wtih_device_type' do
    before do
      user.check_device_type
      user.save
    end
    subject do
      User.find(user.id).device_type
    end
    it { is_expected.to eq 'firefox' }
    context 'when browser is not define' do
      let(:user) { create(:user, user_agent: 'TestHost') }
      it { is_expected.to be nil }
    end
  end
end
