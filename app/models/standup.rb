class Standup < ApplicationRecord
  belongs_to :user
  belongs_to :team
  has_many :blockers

  accepts_nested_attributes_for :blockers, reject_if: proc { |attributes| attributes[:body].blank? }

  validates :body, presence: true, length: { minimum: 10, maximum: 1200 }
end
