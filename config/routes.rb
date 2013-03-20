ScheduleManager::Application.routes.draw do

    root    to: 'app#home'    
    match '/schedules/:id', to: 'schedules#show'

    resources :sessions, only: [:new,:create,:destroy]
    resources :users, only: [:new,:create,:edit,:update]
    resources :schools, path: '', only: [:show] do
      resources :groups, path: '', only: [:show] do
        resources :schedules, path: ''
      end
    end
    resources :items, only: [:show,:create,:edit,:destroy,:update]

    match '/signout', to: 'sessions#destroy', via: :delete
    match '/c', to: 'schedules#schedules_count'

end
