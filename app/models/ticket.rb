# == Schema Information
#
# Table name: my_events
#
#  id        :integer          not null, primary key
#  users_id  :integer
#  events_id :integer
#

class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user_id, presence: true
  validates :event_id, presence: true
end
