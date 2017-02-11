Rails.application.routes.draw do
  resources :shortener, except: :show
  match '/shortener/:id/:unique_key', to: 'shortener#show', via: :get
  get '/:unique_key' => 'shortener#fetch_shortener'
end
