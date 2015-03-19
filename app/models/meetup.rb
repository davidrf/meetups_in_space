class Meetup < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, presence: true, length: { maximum: 127 }
  validates :description, presence: true, length: { maximum: 4095 }
  validates :location, presence: true, length: { maximum: 127 }
end
