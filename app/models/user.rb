class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :team_users
  has_many :teams, through: :team_users
  has_many :sent_invites, class_name: "Invite", foreign_key: "sender_id"
  has_many :standups

  validates :name, presence: true, length: { maximum: 50 }

  def role_for_team(team)
    TeamUser.find_by(team: team, user: self).role
  end
end
