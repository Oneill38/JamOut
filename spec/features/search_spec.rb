require'spec_helper'

describe "visiting the site" do

  describe "a non logged in user visits the site" do
    it "has a signup link" do
      visit root_path
      click_button "Sign Up"
      expect(current_path).to eq "/users/new"
    end

    it"has a login link" do
      visit root_path
      click_button "Login"
      expect(current_path).to eq "/session/new"
    end

  end

  describe "a logged in user visits the site" do
    let(:user) {FactoryGirl.build(:user)}
    it "allows you to search for concerts" do
      visit root_path
      click_button "Login"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Login"
      click_button "JamOut!"
      expect(current_path).to eq "/search/new"
    end

    it "should have a link that allows you to view your events" do
      visit root_path
      click_button "My Events"
      expect(current_path).to eq "/tickets"
    end

    it "should let a valid user login" do
    let(:user) {FactoryGirl.build(:user)}
    visit root_path
    click_button "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"
    expect(page).to have_content("My Events")
  end

  end

end
