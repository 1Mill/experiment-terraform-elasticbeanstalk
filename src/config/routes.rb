Rails.application.routes.draw do
  resources :articles
	resources :articles

	root "welcome#index"
end
