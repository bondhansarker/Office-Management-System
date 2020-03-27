require 'rails_helper'
driver = Selenium::WebDriver.for :chrome

RSpec.feature "Home", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
    #login_as(@user, :scope => :user)
  end

  context "sign in" do
    it "displays the dashboard of the application" do
      driver.get("http://localhost:3000")
      sleep(3)
=begin
      driver.find_element(name: "user_email").send_keys(@user.email)
      driver.find_element(name: "user_password").send_keys("111111")
      driver.find_element(css: "input[type='submit']").click
=end

    end
  end
end
