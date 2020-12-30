Rails.application.routes.draw do
  namespace :api, constraints: -> (request) { request.format == :json } do
    resources :interface_languages, only: [:index, :show]
    resources :content_languages, only: [:index, :show]

    resources :tags, only: [] do
      scope module: :tags do
        resource :translations, only: [:show]
      end
    end

    resources :genres, only: [:index, :show]
    resources :formats, only: [:index, :show]
    resources :demographics, only: [:index, :show]
  end
end
