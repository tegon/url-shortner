Rails.application.routes.draw do
  get '/:code', to: 'urls#show'

  resources :urls, except: :show
end
