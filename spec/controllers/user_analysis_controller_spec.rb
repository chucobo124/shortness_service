require 'rails_helper'

RSpec.describe UserAnalysisController, type: :controller do
  describe '#index' do
      subject { get :index }
    it 'returns the shortener object' do
      subject
      expect(assigns(:shorteners)).to eq Shortener.all
    end
  end
end
