Rails.application.routes.draw do
  devise_for :recruiters

  namespace :api do
    namespace :v1 do
      resources :jobs, only: %i[index create update destroy] do
        member do
          patch :publish
          patch :archive
        end
      end
    end
  end
end
