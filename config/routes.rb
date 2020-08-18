# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root "home#index"
  resources :urls, except: [:edit, :update] do
    resources :keywords, only: [:destroy, :new, :create]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  namespace "api" do
    namespace "v1" do
      resources :ranks, only: [:index]
    end
    get "reference", to: "reference#index"
  end

  get "tos" => "welcome#tos"
  get "policy" => "welcome#policy"
end
