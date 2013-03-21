ScheduleManager::Application.routes.draw do

    root    to: 'app#home'    
    resources :schedules
    resources :items, only: [:show,:create,:edit,:destroy,:update]
    resources :sessions, only: [:new,:create,:destroy]
    resources :users, only: [:new,:create,:edit,:update]
    resources :schools, path: '', only: [:show] do
      resources :groups, path: '', only: [:show] do
        resources :schedules, path: ''
      end
    end
    match '/signout', to: 'sessions#destroy', via: :delete
    match '/c', to: 'schedules#schedules_count'

end
