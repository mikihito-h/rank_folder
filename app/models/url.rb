# frozen_string_literal: true

class Url < ApplicationRecord
  belongs_to :user
  has_many :keywords, dependent: :destroy
  accepts_nested_attributes_for :keywords, reject_if: :all_blank, allow_destroy: true
  validates :url, presence: true
end
