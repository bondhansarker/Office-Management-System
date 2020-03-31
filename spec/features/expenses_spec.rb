require 'rails_helper'
driver = Selenium::WebDriver.for :firefox

RSpec.feature "Expense", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  context "sign in" do
    it "displays the dashboard of the application" do
      driver.get("http://localhost:3000")

      driver.manage().window().maximize()
      sleep(2)
      driver.find_element(:css, "#user_email").send_keys("bondhansarker100@gmail.com")
      driver.find_element(:css, "#user_password").send_keys("111111")
      sleep(2)
      driver.find_element(css: "input[type='submit']").click
      sleep(2)
      driver.find_element(:css, "#expense").click
      sleep(2)
      driver.find_element(:css, "#add_new_expense").click
      sleep(2)
      driver.find_element(:css, "#expense_product_name").send_keys("Test expense")
      driver.find_element(:css, "#expense_category_id").click
      driver.find_element(:css, "#expense_category_id").click
      driver.find_element(:css, "#expense_cost").send_keys("100")
      driver.find_element(:css, "#expense_details").send_keys("Running test")
      driver.find_element(:css, "#datepicker").send_keys("2020-03-21")
      sleep(2)
      driver.find_element(css: "input[type='submit']").click
      sleep(2)
      driver.find_element(css: ".fa-eye").click
      sleep(2)
      driver.find_element(css: ".btn-dark").click
      sleep(2)
      driver.find_element(css: ".fa-edit").click
      sleep(2)
      driver.find_element(:css, "#expense_product_name").send_keys(" Edited ")
      sleep(2)
      driver.find_element(css: "input[type='submit']").click
      sleep(2)
      driver.find_element(css: ".fa-trash").click
      sleep(2)
      driver.switch_to().alert().accept()
      sleep(2)
      driver.quit

    end
  end

end
