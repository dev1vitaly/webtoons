Rails.application.routes.draw do
  resources :documentations, only: [:index]

  namespace :api, constraints: ->(request) { request.format == :json } do
    resource :sign_up, only: [:create], controller: :sign_up
    resource :sign_in, only: [:create], controller: :sign_in
    resource :sign_out, only: [:destroy], controller: :sign_out

    resources :interface_languages, only: [:index, :show]
    resources :content_languages, only: [:index, :show]

    resources :tags, only: [:index, :show] do
      scope module: :tags do
        resource :translations, only: [:show]
      end
    end

    resources :marks, only: [:index, :show]
    resources :genres, only: [:index, :show]
    resources :themes, only: [:index, :show]
    resources :formats, only: [:index, :show]
    resources :demographics, only: [:index, :show]
    resources :users, only: [:index, :show]

    resources :artists, only: [:index, :show] do
      scope module: :artists do
        resources :favorites, only: [:create, :destroy]
      end
    end

    resources :writers, only: [:index, :show]
    resources :painters, only: [:index, :show]
    resources :cleaners, only: [:index, :show]
    resources :translators, only: [:index, :show]
    resources :editors, only: [:index, :show]
    resources :typers, only: [:index, :show]

    resources :groups, only: [:index, :show] do
      scope module: :groups do
        resources :favorites, only: [:create, :destroy]
      end
    end

    resources :titles, only: [:index, :show, :create] do
      scope module: :titles do
        resource :cover, only: [:update, :destroy], controller: :cover
        resources :covers, only: [:index, :show, :create, :destroy]
        resources :volumes, only: [:index, :show]
        resources :views, only: [:create]
        resources :bookmarks, only: [:create, :destroy]
        resources :favorites, only: [:create, :destroy]

        resources :chapters, only: [:index, :show] do
          scope module: :chapters do
            resource :cover, only: [:update, :destroy], controller: :cover
            resources :views, only: [:create]
            resources :bookmarks, only: [:create, :destroy]

            resources :pages, only: [:index, :show] do
              scope module: :pages do
                resources :views, only: [:create]
                resources :bookmarks, only: [:create, :destroy]
              end
            end
          end
        end
      end
    end
  end
end
