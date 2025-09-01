Rails.application.routes.draw do
  devise_for :recruiters

  namespace :api do
    namespace :v1 do
      get 'candidates/index'
      resources :jobs, only: %i[index create update destroy] do
        member do
          patch :publish
          patch :archive
        end
      end
      get "candidates", to: "candidates#index"
    end
  end
end
