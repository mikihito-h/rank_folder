# frozen_string_literal: true

class Url < ApplicationRecord
  validates :url, presence: true
  has_many :keywords
end
