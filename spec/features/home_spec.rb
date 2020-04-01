require 'rails_helper'
options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
driver = Selenium::WebDriver.for :firefox, options: options

RSpec.feature "Home", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  context "sign in" do
    it "displays the dashboard of the application" do
      login_as_super_admin(driver)
      logout_from_system(driver)
      sleep(1)
      login_as_admin(driver)
      logout_from_system(driver)
      sleep(1)
      login_as_employee(driver)
      logout_from_system(driver)

      driver.quit
    end
  end

end
