require 'rails_helper'
driver = Selenium::WebDriver.for :chrome

RSpec.feature "Home", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  context "sign in" do
    it "displays the dashboard of the application" do
      sleep(20)
      driver.get("http://localhost:3000")
      sleep(5)
      driver.find_element(:css, "#user_email").send_keys("admin@rightcodes.org")
      driver.find_element(:css, "#user_password").send_keys("111111")
      sleep(3)
      driver.find_element(css: "input[type='submit']").click
      element = driver.find_element(:css, "h3").text
      "User Dashboard".eql? element
      sleep(5)

      driver.quit


    end
  end

end
