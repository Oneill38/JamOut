# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  street     :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :integer
#  created_at :datetime
#  updated_at :datetime
#

class Venue < ActiveRecord::Base
  has_many :events
  has_many :artists, through: :events

  validates :name, uniqueness: { scope: :street }
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
end
