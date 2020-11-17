class Like < ApplicationRecord
  belongs_to :user
  belongs_to :photopost
  counter_culture :photopost
  validates  :user_id,      presence: true
  validates  :photopost_id, presence: true
end
