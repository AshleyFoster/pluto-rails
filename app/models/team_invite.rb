class TeamInvite < ApplicationRecord
  before_save :user_exists?
  has_secure_token

  belongs_to :team
  belongs_to :user
  has_many :emails

  validates :email, presence: true, length: { minimum: 6 }
  validates_uniqueness_of :email, scope: :team_id

  def user_exists?
    recipient = User.find_by_email(email)
  end
end
