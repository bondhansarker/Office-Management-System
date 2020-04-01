require 'rails_helper'
options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
driver = Selenium::WebDriver.for :firefox, options: options

RSpec.feature "Expense", type: :feature do

  context "Create" do
    it "should be successful" do
      login_as_employee(driver)
      driver.manage().window().maximize()
      driver.find_element(:css, "#expnese_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(1) > div > div > div > a:nth-child(2)").click
      driver.current_url.eql? expenses_url
      driver.find_element(:css, "h1").text.eql? "Expense List"
      create_expense(driver, "1. March Remove", "03")
      create_expense(driver, "2. March Reject", "03")
      driver.execute_script("window.scrollTo(0, 200)")
      create_expense(driver, "3. March Undo", "03")
      driver.execute_script("window.scrollTo(0, 250)")
      create_expense(driver, "4. March Approve", "03")
      driver.execute_script("window.scrollTo(0, 300)")
    end
  end

  context "Show" do
    it "should be successful" do
      driver.find_element(css: "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(1)").click
      driver.find_element(css: ".btn-dark").click
      driver.execute_script("window.scrollTo(0, 300)")
    end
  end

  context "Destroy" do
    it "should be successful" do
      driver.find_element(css: "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(3)").click
      driver.switch_to.alert.accept
      driver.current_url.eql? expenses_url
      driver.find_element(:css, "h1").text.eql? "Expense List"
      driver.execute_script("window.scrollTo(0, 300)")
    end
  end

  context "Edit_Update" do
    it "should be successful" do
      driver.find_element(css: "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(3) > td:nth-child(6) > a:nth-child(2)").click
      driver.find_element(:css, "#expense_product_name").send_keys(" Edited ")
      driver.find_element(css: "input[type='submit']").click
      driver.execute_script("window.scrollTo(0, 300)")
    end
  end

  context "Logout as Employee" do
    it "should be successful" do
      logout_from_system(driver)
    end
  end

  context "View all the expenses" do
    it "should be successful" do
      login_as_admin(driver)
      driver.find_element(:css, "#expnese_menu").click
      driver.find_element(:css, "#navbarResponsive > ul > li:nth-child(3) > div > div > div > a:nth-child(2)").click
      driver.current_url.eql? expenses_url
      driver.find_element(:css, "h1").text.eql? "Expense List"
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-warning").click
      driver.execute_script("window.scrollTo(0, 300)")
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-success").click
      driver.execute_script("window.scrollTo(0, 300)")
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-danger").click
      driver.execute_script("window.scrollTo(0, 300)")
    end
  end

  context "Reject" do
    it "should be successful" do

      driver.execute_script("window.scrollTo(document.body.scrollHeight,0)")
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-warning").click
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(2)").click
      driver.switch_to.alert.accept
      driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-danger").click
      driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
    end
  end

  context "Approve" do
    it "should be successful" do
      driver.execute_script("window.scrollTo(document.body.scrollHeight,0)")
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(1)").click
      driver.switch_to.alert.accept
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-success").click
      driver.execute_script("window.scrollTo(0, 300)")
      driver.find_element(:css, "#pending > div.table-responsive-sm > table > tbody > tr:nth-child(1) > td:nth-child(6) > a:nth-child(1)").click
      driver.switch_to.alert.accept
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-success").click
      driver.execute_script("window.scrollTo(0, 300)")
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
      driver.switch_to.alert.accept
      sleep(1)
      driver.find_element(:css, "body > div.container-fluid.px-4.mx-auto > div.container-fluid.px-4.mx-auto > button.accordion.btn.btn-success").click
      sleep(1)
      driver.execute_script("window.scrollTo(0, 300)")
      sleep(2)
      driver.execute_script("window.scrollTo(document.body.scrollHeight,0)")
      sleep(2)
      driver.current_url.eql? expenses_url
      driver.find_element(:css, "h1").text.eql? "Expense List"
      logout_from_system(driver)
      sleep(2)
      driver.quit
    end
  end
end