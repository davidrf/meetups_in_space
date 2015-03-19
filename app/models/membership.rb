class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup

  validates :user_id, presence: true, numericality: true
  validates :meetup_id, presence: true, numericality: true
end
