class Blocker < ApplicationRecord
  belongs_to :standup

  validates :body, length: { maximum: 50 }
end
