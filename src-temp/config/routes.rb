Rails.application.routes.draw do
  resources :articles
	resources :articles

	root "articles#index"
end
