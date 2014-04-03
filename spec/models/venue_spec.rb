require'spec_helper'

describe Venue do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:street)}
  it {should validate_presence_of (:city)}
  it {should validate_presence_of (:state)}
end
