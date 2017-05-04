class Standup < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :body, presence: true, length: { maximum: 100 }
end
