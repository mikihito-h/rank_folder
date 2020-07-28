# frozen_string_literal: true

class Url < ApplicationRecord
  validates :url, presence: true
  belongs_to :user
  has_many :keywords, dependent: :destroy
  accepts_nested_attributes_for :keywords, reject_if: :all_blank, allow_destroy: true
end
