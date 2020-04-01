## README

* [USER_AUTHENTICATION](https://bitbucket.org/rightcodes/office_management/src/user_authentication_api/api_docs/USER_AUTHENTICATION.md)

* [ALLOCATED LEAVE](https://bitbucket.org/rightcodes/office_management/src/user_authentication_api/api_docs/ALLOCATED_LEAVES.md)

* [ATTENDANCE](https://bitbucket.org/rightcodes/office_management/src/user_authentication_api/api_docs/ATTENDANCES.md)

* [BUDGET](https://bitbucket.org/rightcodes/office_management/src/user_authentication_api/api_docs/BUDGETS.md)

* [CATEGORY](https://bitbucket.org/rightcodes/office_management/src/user_authentication_api/api_docs/CATEGORIES.md)

* [EXPENSE](https://bitbucket.org/rightcodes/office_management/src/user_authentication_api/api_docs/EXPENSES.md)

* [HOME](https://bitbucket.org/rightcodes/office_management/src/user_authentication_api/api_docs/HOME.md)

* [INCOME](https://bitbucket.org/rightcodes/office_management/src/user_authentication_api/api_docs/INCOMES.md)

* [LEAVE](https://bitbucket.org/rightcodes/office_management/src/user_authentication_api/api_docs/LEAVES.md)

* [USER](https://bitbucket.org/rightcodes/office_management/src/user_authentication_api/api_docs/USERS.md)



### SYSTEM TEST

* To run system test, first clone the project using the following command in the terminal.

       `git clone git@bitbucket.org:rightcodes/office_management.git`
       
* Include the following gems in your Gemfile.


```ruby
    group :development do
         gem "factory_bot_rails"
         gem "faker"
         gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails', branch: "4-0-maintenance" 
         gem 'rails-controller-testing'
    end
    
    group :test do
        gem 'capybara', '~> 2.7', '>= 2.7.1'
        gem 'selenium-webdriver'
        gem 'webdrivers'
    end
```
    
* Run `bundle` in the terminal to install the gems.

* To run the test, just run `rspec` command in the terminal.

* To know more about the gems, here are the necessary links-
    
    * [Capybara](https://github.com/teamcapybara/capybara/blob/3.32_stable/README.md)
    * [FactoryBot](https://github.com/thoughtbot/factory_bot_rails)
    * [Faker](https://github.com/faker-ruby/faker)
    * [Rspec](https://github.com/rspec/rspec-rails)
    * [Rails Controller Testing](https://github.com/rails/rails-controller-testing)
    * [Selenium Webdriver](https://github.com/SeleniumHQ/selenium/tree/master/rb)
    * [Webdrivers](https://github.com/titusfortner/webdrivers)
