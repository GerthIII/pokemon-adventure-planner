class Message < ApplicationRecord
  belongs_to :team

  validates :content, presence: true
  validates :role, presence: true
end
