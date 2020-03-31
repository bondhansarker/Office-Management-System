require 'rails_helper'
driver = Selenium::WebDriver.for :firefox

RSpec.feature "Expense", type: :feature do

  context "Create" do
    it "should be successful" do
      login_as_employee(driver)
      driver.manage().window().maximize()
      sleep(1)
      driver.find_element(:css, "#expnese_menu").click
      sleep(1)
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(1) > div > div > div > a:nth-child(2)").click
      sleep(1)
      create_expense(driver, "1. March Remove", "03")
      create_expense(driver, "2. March Reject", "03")
      driver.execute_script("window.scrollTo(0, 200)")
      sleep(1)
      create_expense(driver, "3. March Undo", "03")
      driver.execute_script("window.scrollTo(0, 250)")
      sleep(1)
      create_expense(driver, "4. March Approve", "03")
      driver.execute_script("window.scrollTo(0, 300)")
    end
  end

  context "Show" do
    it "should be successful" do
      sleep(1)
      driver.find_element(css: "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(1)").click
      sleep(2)
      driver.find_element(css: ".btn-dark").click
      sleep(1)
      driver.execute_script("window.scrollTo(0, 300)")
      sleep(2)
    end
  end

  context "Destroy" do
    it "should be successful" do
      driver.find_element(css: "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(3)").click
      sleep(1)
      driver.switch_to().alert().accept()
      sleep(1)
      driver.execute_script("window.scrollTo(0, 300)")
      sleep(2)
    end
  end

  context "Edit_Update" do
    it "should be successful" do
      driver.find_element(css: "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(3) > td:nth-child(6) > a:nth-child(2)").click
      sleep(1)
      driver.find_element(:css, "#expense_product_name").send_keys(" Edited ")
      sleep(1)
      driver.find_element(css: "input[type='submit']").click
      sleep(2)
      driver.execute_script("window.scrollTo(0, 300)")
      sleep(2)
    end
  end

  context "Logout" do
    it "should be successful" do
      logout_from_system(driver)
    end
  end

  context "View all the expenses" do
    it "should be successful" do
      login_as_admin(driver)
      driver.find_element(:css, "#expnese_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(3) > div > div > div > a:nth-child(2)").click
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-warning").click
      sleep(1)
      driver.execute_script("window.scrollTo(0, 300)")
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-success").click
      sleep(1)
      driver.execute_script("window.scrollTo(0, 300)")
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-danger").click
      sleep(1)
      driver.execute_script("window.scrollTo(0, 300)")
      sleep(1)
    end
  end

  context "Reject" do
    it "should be successful" do

      driver.execute_script("window.scrollTo(document.body.scrollHeight,0)")
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-warning").click
      sleep(1)
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(2)").click
      sleep(1)
      driver.switch_to().alert().accept()
      sleep(1)
      driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-danger").click
      sleep(1)
      driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
      sleep(2)
    end
  end

  context "Approve" do
    it "should be successful" do
      driver.execute_script("window.scrollTo(document.body.scrollHeight,0)")
      sleep(1)
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(1)").click
      sleep(1)
      driver.switch_to().alert().accept()
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-success").click
      sleep(1)
      driver.execute_script("window.scrollTo(0, 300)")
      sleep(1)
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(1)").click
      sleep(1)
      driver.switch_to().alert().accept()
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-success").click
      sleep(1)
      driver.execute_script("window.scrollTo(0, 300)")
      sleep(1)
      driver.find_element(:css, "#approved > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(2)").click
      sleep(1)
      driver.find_element(css: ".btn-dark").click
      sleep(1)
      driver.execute_script("window.scrollTo(0, 300)")
      sleep(3)
    end
  end

  context "Undo" do
    it "should be successful" do
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-success").click
      sleep(1)
      driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
      sleep(1)
      driver.find_element(:css, "#approved > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(1)").click
      sleep(1)
      driver.switch_to().alert().accept()
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-success").click
      sleep(1)
      driver.execute_script("window.scrollTo(0, 300)")
      sleep(2)
      driver.execute_script("window.scrollTo(document.body.scrollHeight,0)")
      sleep(2)
      driver.quit
    end
  end
end