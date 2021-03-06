Rails.application.routes.draw do

  root 'home#index'
  
  devise_for :collaborators, controllers: { sessions: 'collaborators/sessions', registrations: 'collaborators/registrations' }
  devise_for :candidates, controllers: { sessions: 'candidates/sessions', registrations: 'candidates/registrations' }

  resources :collaborators, only: %i[index]
  resources :candidates, only: %i[index show edit update] do
    post 'approve', on: :member
    post 'disapprove', on: :member
    get 'my_jobs', on: :member

  end
  
  resources :candidate_jobs, only: %i[edit update]

  get 'search_company', to: "companies#search"
  resources :companies, only: %i[index show new create edit update]

  get 'search_job', to: "jobs#search"
  resources :jobs, only: %i[index show new create edit update] do
    post 'application', on: :member
    post 'decline', on: :member
    post 'accept', on: :member
    post 'disable', on: :member
  end

end
