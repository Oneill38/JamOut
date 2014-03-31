# == Schema Information
#
# Table name: my_events
#
#  id        :integer          not null, primary key
#  users_id  :integer
#  events_id :integer
#

class My_Event < ActiveRecord::Base
  belongs_to :user
  has_one :event
end
