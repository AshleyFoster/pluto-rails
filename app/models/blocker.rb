class Blocker < ApplicationRecord
  belongs_to :standup

  validates :body, length: { minimum: 3, maximum: 50 }
end
