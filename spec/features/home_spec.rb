require 'rails_helper'
driver = Selenium::WebDriver.for :firefox

RSpec.feature "Home", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  context "sign in" do
    it "displays the dashboard of the application" do
      login_as_super_admin(driver)
      #driver.quit
      sleep(2)
      login_as_admin(driver)
      #driver.quit
      sleep(2)
      login_as_employee(driver)
      driver.quit
    end
  end

end
