# frozen_string_literal: true

class Keyword < ApplicationRecord
  belongs_to :url
  validates :keyword, presence: true
end
