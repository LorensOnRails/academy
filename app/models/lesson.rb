class Lesson < ApplicationRecord

  validates :title, presence: true, length: { within: 5..50 }
  validates :workshop_id, presence: true
  validates :account_id, presence: true
  belongs_to :workshop

end
