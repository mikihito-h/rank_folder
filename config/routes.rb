# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root "urls#index"
  resources :urls, except: [:edit, :update] do
    resources :keywords, only: [:destroy]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  namespace "api" do
    namespace "v1" do
      resources :ranks, only: [:index]
    end
  end
end
