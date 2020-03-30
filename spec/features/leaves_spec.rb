require 'rails_helper'
driver = Selenium::WebDriver.for :chrome

RSpec.feature "Leaves", type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

end
