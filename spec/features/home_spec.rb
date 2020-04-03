require 'rails_helper'
RSpec.feature "Home", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
  end

  context "After login" do
    it "displays the dashboard of the application" do
      visit(root_url)
      expect(find(:css, "h3").text).to eq("#{@user.role}'s Dashboard")
      expect(page).to have_content("Budget Statistics")
      expect(page).to have_content("Revenue Graph")
    end
  end
end
