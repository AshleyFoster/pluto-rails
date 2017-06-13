class Team < ApplicationRecord
  has_many :team_users
  has_many :users, through: :team_users
  has_many :standups
  has_many :team_invites

  validates :name,  presence: true, length: { maximum: 50 },
    uniqueness: { case_sensitive: false }

  validates :time, presence: true
end
