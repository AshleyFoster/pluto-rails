class Standup < ApplicationRecord
  belongs_to :user
  belongs_to :team
  has_many :blockers

  accepts_nested_attributes_for :blockers

  validates :body, presence: true, length: { maximum: 1200 }
end
