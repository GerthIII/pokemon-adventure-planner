class Message < ApplicationRecord
  belongs_to :team

  validates :content, presence: true, length: { minimum: 5}
  validates :role, presence: true
end
