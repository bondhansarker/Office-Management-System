require 'rails_helper'
driver = Selenium::WebDriver.for :firefox

RSpec.feature "Home", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  context "sign in" do
    it "displays the dashboard of the application" do
      login_as_super_admin(driver)
      sleep(2)
      logout_from_system(driver)
      sleep(2)
      login_as_admin(driver)
      sleep(2)
      logout_from_system(driver)
      sleep(2)
      login_as_employee(driver)
      sleep(2)
      logout_from_system(driver)

      driver.quit
    end
  end

end
