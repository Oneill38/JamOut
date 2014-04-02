require'spec_helper'

describe Event do
  it { should validate_presence_of(:title)}
  it {should have_many(:tickets)}
end
