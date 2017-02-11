Rails.application.routes.draw do
  resources :shortener, except: :show
  match '/user_analysis', to: 'user_analysis#index', via: :get
  match '/shortener/:id/:unique_key', to: 'shortener#show', via: :get
  get '/:unique_key' => 'shortener#fetch_shortener'
end
