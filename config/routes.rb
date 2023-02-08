Rails.application.routes.draw do
  root "pages#home"

  get "/busqueda", to: "pages#results"
  get "/:slug", to: "blog#show"
end
