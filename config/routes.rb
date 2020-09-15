# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#new_guest"
  end

  root "home#index"
  resources :urls, only: [:index, :show, :new, :create, :destroy] do
    resources :keywords, only: [:destroy, :new, :create]
  end
  get "tos", to: "welcome#tos"
  get "policy", to: "welcome#policy"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  namespace :api do
    namespace :v1 do
      resources :ranks, only: [:index]
    end
    resource :reference, only: [:show]
  end
end
