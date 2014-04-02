require'spec_helper'

describe "Event" do
  it "should return a list of events" do
    @results = Event.search(params)
    expect(@results).to be_an_instance_of(Event)
  end

end
