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

###System Test

* To run system test, first clone the project using the following command

       `git clone git@bitbucket.org:rightcodes/office_management.git`
       
* Include the following gems in the `development` group of your Gemfile.

    
    
    group :development do
       gem "factory_bot_rails"
       gem "faker"
       gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails', branch: "4-0-maintenance" 
       gem 'rails-controller-testing'
    end
    
    
   
* Include the following gems in the `test` group of your Gemfile.


    group :test do
        gem 'capybara', '~> 2.7', '>= 2.7.1'
        gem 'selenium-webdriver'
        gem 'webdrivers'
    end
    
* Then run `bundle`

* To run the test, just run `rspec` command in the terminal.
