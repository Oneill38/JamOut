class Event < ActiveRecord::Base
  has_one :venue
  has_many :artists

  validates :title, uniqueness: { scope: :date }
end
