Rails.application.routes.draw do
  devise_for :users
  # , :skip => :registrations
  resources :invoices do
    collection { post :import }
    collection { get :refresh }
    collection { get :master }
    member { get :sendinvoice }
  end

  root 'static_pages#home'
end
