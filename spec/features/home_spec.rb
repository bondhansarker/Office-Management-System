require 'rails_helper'

RSpec.feature "Home", type: :feature do

  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end

  context "sign in" do
    it "displays the dashboard of the application" do
      visit("/")
      expect(page).to have_content("User Dashboard")
    end
  end
end
