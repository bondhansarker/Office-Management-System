require 'rails_helper'

RSpec.feature "Leaves", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
    @user.role = "Super Admin"
    @user.save
    login_as(@user, :scope => :user)
  end

  describe "Create" do
    it "should be successful" do
      visit(root_url)
      click_on 'Employee'
      click_on 'Add new employee'
      expect(current_url).to eq(new_manage_user_url)
      expect(find(:css, "h2").text).to eq("Create a New User")
      within('form') do
        fill_in 'user_email', with: 'test@gmail.com'
        fill_in 'user_password', with: '111111'
        fill_in 'user_password_confirmation', with: '111111'
        fill_in 'user_name', with: 'Test User'
        fill_in 'user_phone', with: '000000111'
        fill_in 'user_target_amount', with: 10000
        fill_in 'user_bonus_percentage', with: 10
        select('Employee', from: 'user_role')
      end
      click_on 'Create new user'
      expect(page).to have_content("User has been created successfully")
      expect(current_url).to eq(manage_users_url)
      expect(find(:css, "h1").text).to eq("Employee List")
      expect(2).to eq(User.count)
    end
  end


  describe "Show" do
    it "should be successful" do
      visit(manage_users_url)
      expect(current_url).to eq(manage_users_url)
      expect(find(:css, "h1").text).to eq("Employee List")
      within('.table-responsive-sm') do
        expect(page).to have_content("#{@user.name}")
        page.find('.show_link').click
      end

      within('.card') do
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.email)
        expect(page).to have_content(@user.phone)
        expect(current_url).to eq(manage_user_url(@user))
      end
      page.find('.btn-dark').click
      expect(current_url).to eq(manage_users_url)
      expect(find(:css, "h1").text).to eq("Employee List")
    end
  end


  describe "Update" do
    it "should be successful" do
      visit(manage_users_url)
      expect(current_url).to eq(manage_users_url)
      expect(find(:css, "h1").text).to eq("Employee List")
      within('.table-responsive-sm') do
        expect(page).to have_content("#{@user.name}")
        page.find('.edit_link').click
      end
      expect(find(:css, "h2").text).to have_content("Edit User Information")
      expect(current_url).to eq(edit_manage_user_url(@user))
      within('form') do
        fill_in 'user_name', with: 'Test User Updated'
      end
      click_on 'Update'
      expect(page).to have_content("User data has been updated successfully")
      expect(current_url).to eq(manage_user_url(@user))
      within('.card') do
        expect(page).to have_content('Test User Updated')
        expect(page).to have_content(@user.email)
        expect(page).to have_content(@user.phone)
        expect(current_url).to eq(manage_user_url(@user))
      end
    end
  end

  context "All Expenses" do
    it "should be successful" do
      visit(manage_users_url)
      expect(current_url).to eq(manage_users_url)
      expect(find(:css, "h1").text).to eq("Employee List")
      within('.table-responsive-sm') do
        expect(page).to have_content("#{@user.name}")
        page.find('.expense_link').click
      end
      expect(current_url).to eq(show_all_expenses_manage_user_url(@user))
      within('.card') do
        expect(find(:css, "h3").text).to have_content("Expense List for #{@user.name}")
      end
      expect(page).to have_content("Pending (#{@user.expenses.pending.count})")
      expect(page).to have_content("Approved (#{@user.expenses.approved.count})")
      expect(page).to have_content("Rejected (#{@user.expenses.rejected.count})")
      click_on 'Back'
      expect(current_url).to eq(manage_users_url)
      expect(find(:css, "h1").text).to eq("Employee List")
    end
  end
  context "All Incomes" do
    it "should be successful" do
      visit(manage_users_url)
      expect(current_url).to eq(manage_users_url)
      expect(find(:css, "h1").text).to eq("Employee List")
      within('.table-responsive-sm') do
        expect(page).to have_content("#{@user.name}")
        page.find('.income_link').click
      end
      expect(current_url).to eq(show_all_incomes_manage_user_url(@user))
      expect(find(:css, "h1").text).to have_content("All Income List of #{@user.name} of year #{Date.today.year}")
      expect(page).to have_content("Pending (#{@user.incomes.pending.count})")
      expect(page).to have_content("Approved (#{@user.incomes.approved.count})")
      expect(page).to have_content("Rejected (#{@user.incomes.rejected.count})")
      click_on 'Back'
      expect(current_url).to eq(manage_users_url)
      expect(find(:css, "h1").text).to eq("Employee List")
    end
  end
end