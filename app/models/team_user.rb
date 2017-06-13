class TeamUser < ApplicationRecord
  OWNER = "owner".freeze
  MEMBER = "member".freeze

  belongs_to :user
  belongs_to :team
  has_many :team_invites
end
