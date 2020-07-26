# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root "urls#index"
  resources :urls, except: [:edit, :update]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
