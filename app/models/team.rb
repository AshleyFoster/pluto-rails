class Team < ApplicationRecord
  belongs_to :user
  has_many :standups

  validates :name,  presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }

  validates :time, presence: true
end
