DirtyLoveAffairs::Application.routes.draw do
  root to: redirect('/dashboard')

  # authentication
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout
  match 'auth/facebook/callback', to: 'sessions#create', via: %w(get post)
  match 'auth/failure', to: redirect('/'), via: %w(get post)

  # app
  get 'dashboard', to: 'dashboards#show', as: :dashboard
  resources :users, only: :index
  namespace :admin do
    resources :meetings do
      resources :meeting_attendances, only: %w{create destroy}
    end

    resources :teams
    resources :shames
    resources :users
    resources :feedbacks
    resources :enrolments do
      root to: redirect('/admin/enrolments/pending')
      get :pending, on: :collection
      put :approve, on: :member
    end
  end
  
  resources :approvals, only: %w(index show) do
    resources :approval_votes
  end

  resources :teams
  resources :shames, only: %w(index)
  resources :enrolments, only: %w(index create show update destroy)

  namespace :fundraising do
    root to: redirect('/fundraising/fundraisers')
    resources :fundraisers
  end

  resource :profile, only: %w(show edit update) do
    put :resend_email_confirmation
    get :confirm_email
  end


  get :help, to: 'help#index'
end
