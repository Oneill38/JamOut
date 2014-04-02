require'spec_helper'

describe Ticket do
  it {should belong_to(:user)}
  it { should belong_to(:event)}
end
