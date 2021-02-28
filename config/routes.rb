Rails.application.routes.draw do

  root 'home#index'
  
  devise_for :collaborators, controllers: { sessions: 'collaborators/sessions', registrations: 'collaborators/registrations' }
  devise_for :candidates, controllers: { sessions: 'candidates/sessions', registrations: 'candidates/registrations' }

  resources :collaborators, only: %i[index]
  resources :candidates, only: %i[index show edit update]
  resources :companies, only: %i[index show new create edit update]
  resources :jobs, only: %i[index show new create edit update] do
    post 'application', on: :member
  end

end
