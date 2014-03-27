class My_Event < ActiveRecord::Base
  belongs_to :user
  has_one :event
end
