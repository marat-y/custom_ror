class Event < ApplicationRecord
  validates :title, :starttime, presence: true

  belongs_to :user
end
