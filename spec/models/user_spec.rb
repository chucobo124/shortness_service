require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let(:shortener) { create(:shortener, user: user) }

  describe 'shortener' do
    subject { User.first }
    it { is_expected.to eq shortener.user }
  end
end
