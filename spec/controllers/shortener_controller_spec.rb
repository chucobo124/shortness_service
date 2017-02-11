require 'rails_helper'

RSpec.describe ShortenerController, type: :controller do
  let(:unique_key) { SecureRandom.hex(5) }
  let(:url) { Faker::Internet.url }
  let(:user) { create(:user) }

  describe '#show' do
    before do
      user.shorteners.create(url: url, unique_key: unique_key)
    end
    subject { get :show, params: { id: user.id, unique_key: unique_key } }
    it { is_expected.to have_http_status(:ok) }
    it 'returns the shortener' do
      subject
      expect(assigns(:shortener_url))
        .to eq "http://test.host/#{unique_key}"
    end
  end

  describe '#create' do
    let(:params_data) { { shortener: { origin_url: Faker::Internet.url } } }
    subject { post :create, params: params_data }
    it { is_expected.to have_http_status(:redirect) }
    it 'saves the shortener' do
      subject
      expect(Shortener.find_by_url(params_data[:origin_url])).not_to be nil
    end
    context 'when user is robot' do
      it 'blocks the user and give 404'
    end
  end

  describe '#fetch_shortener' do
    before do
      user.shorteners.create(url: url, unique_key: unique_key)
    end
    subject { get :fetch_shortener, params: { unique_key: unique_key } }
    it 'redirects to the origin url' do
      subject
      expect(response).to redirect_to(url)
    end
  end
end
