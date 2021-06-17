class Event < ApplicationRecord
  validates :title, :starttime, presence: true
end
