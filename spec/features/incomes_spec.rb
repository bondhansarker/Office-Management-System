require 'rails_helper'

RSpec.feature "Incomes", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
    @user.role = "Employee"
    @user.save
    @income = FactoryBot.create(:income, user: @user)
    login_as(@user, :scope => :user)
  end


  describe "Create" do
    it "should be successful" do
      visit(root_url)
      click_on 'Income'
      click_on 'Add new income'
      expect(current_url).to eq(new_income_url)
      expect(find(:css, "h1").text).to eq("Add Income")
      within('form') do
        fill_in 'income_amount', with: '1000'
        fill_in 'datepicker', with: '2020-01-01'
      end
      click_on 'Save'
      expect(page).to have_content("Your income has been submitted for approval")
      expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))
      expect(find(:css, "h1").text).to eq("All Income List of #{@income.user.name}")
      expect(2).to eq(Income.count)
      expect(page).to have_content("Pending (#{Income.pending.count})")
    end
  end


  describe "Show" do
    context "Pending" do
      it "should be successful" do
        visit(root_url)
        click_on 'Income'
        click_on 'Incomes'
        expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))
        expect(find(:css, "h1").text).to eq("All Income List of #{@income.user.name}")
        expect(page).to have_content("Pending (#{Income.pending.count})")
        expect(page).to have_content(@income.user.name)
        within('#pending') do
          page.find('.show_link').click
        end
        expect(find(:css, "h1").text).to eq("Details of Income")

        within('.col-md-5') do
          expect(page).to have_content(@income.user.name)
          expect(page).to have_content("Pending")
          expect(current_url).to eq(income_url(@income))
        end
        page.find('.btn-dark').click
        expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))
      end
    end
  end

  context "Destroy" do
    it "should be successful" do
      visit(root_url)
      click_on 'Income'
      click_on 'Incomes'
      expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))
      expect(find(:css, "h1").text).to eq("All Income List of #{@income.user.name}")
      expect(page).to have_content("Pending (#{Income.pending.count})")
      expect(page).to have_content(@income.user.name)
      within('#pending') do
        page.find('.destroy_link').click
      end
      expect(current_url).to eq(show_all_incomes_manage_user_url(@user))
      expect(0).to eq(Income.count)
      expect(page).to have_content("Pending (#{Income.pending.count})")
    end
  end

  context "Update" do
    it "should be successful" do
      visit(root_url)
      click_on 'Income'
      click_on 'Incomes'
      expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))
      expect(find(:css, "h1").text).to eq("All Income List of #{@income.user.name}")
      expect(page).to have_content("Pending (#{Income.pending.count})")
      expect(page).to have_content(@income.user.name)
      within('#pending') do
        page.find('.edit_link').click
      end
      expect(page).to have_content("Edit")
      expect(page).to have_content("User: #{@income.user.name}")
      within('form') do
        fill_in 'income_amount', with: '1500'
      end
      click_on 'Update'
      expect(page).to have_content("Your income information has been updated")
      expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))
      expect(find(:css, "h1").text).to eq("All Income List of #{@income.user.name}")
      expect(Income.last.amount).to eq(1500)
    end
  end

  context "Reject" do
    it "should be successful" do
      @admin_user = FactoryBot.create(:user)
      @admin_user.role = "Admin"
      @admin_user.save
      login_as(@admin_user, :scope => :user)
      visit(root_url)
      click_on 'Income'
      click_on 'Incomes'
      expect(current_url).to eq(incomes_url)
      expect(find(:css, "h1").text).to eq("All Income List of #{Date.today.year}")
      within('#income') do
        click_on "#{@income.user.name}"
      end
      expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))
      expect(find(:css, "h1")).to have_content("All Income List of #{@income.user.name} of year #{Date.today.year}")
      expect(page).to have_content("Pending (#{Income.pending.count})")
      expect(0).to eq(Income.rejected.count)
      expect(1).to eq(Income.pending.count)
      within('#pending') do
        page.find('.reject_link').click
      end
      expect(page).to have_content("Income has been rejected")
      expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))
      expect(1).to eq(Income.rejected.count)
      expect(0).to eq(Income.pending.count)
      expect(page).to have_content("Rejected (#{Income.rejected.count})")
    end
  end


  describe "Approval" do
    context "Approve" do
      it "should be successful" do
        @admin_user = FactoryBot.create(:user)
        @admin_user.role = "Admin"
        @admin_user.save
        login_as(@admin_user, :scope => :user)
        visit(root_url)
        click_on 'Income'
        click_on 'Incomes'
        expect(current_url).to eq(incomes_url)
        expect(find(:css, "h1").text).to eq("All Income List of #{Date.today.year}")
        within('#income') do
          click_on "#{@income.user.name}"
        end
        expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))
        expect(find(:css, "h1")).to have_content("All Income List of #{@income.user.name} of year #{Date.today.year}")
        expect(page).to have_content("Pending (#{Income.pending.count})")
        expect(0).to eq(Income.rejected.count)
        expect(1).to eq(Income.pending.count)
        within('#pending') do
          page.find('.approve_link').click
        end
        expect(page).to have_content("Income has been approved")
        expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))

        expect(0).to eq(Income.pending.count)
        expect(1).to eq(Income.approved.count)
        expect(page).to have_content("Approved (#{Income.approved.count})")
        expect(page).to have_content("Pending (#{Income.pending.count})")
      end
    end

    context "Undo" do
      it "should be successful" do
        @admin_user = FactoryBot.create(:user)
        @admin_user.role = "Admin"
        @admin_user.save
        login_as(@admin_user, :scope => :user)
        @income.approved!
        visit(root_url)
        click_on 'Income'
        click_on 'Incomes'
        expect(current_url).to eq(incomes_url)
        expect(find(:css, "h1").text).to eq("All Income List of #{Date.today.year}")
        within('#income') do
          click_on "#{@income.user.name}"
        end
        expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))
        expect(find(:css, "h1")).to have_content("All Income List of #{@income.user.name} of year #{Date.today.year}")
        expect(page).to have_content("Pending (#{Income.pending.count})")
        expect(0).to eq(Income.pending.count)
        expect(1).to eq(Income.approved.count)
        within('#approved') do
          page.find('.undo_link').click
        end
        expect(page).to have_content("The income status has been changed successfully")
        expect(current_url).to eq(show_all_incomes_manage_user_url(@income.user))
        expect(1).to eq(Income.pending.count)
        expect(0).to eq(Income.approved.count)
        expect(page).to have_content("Approved (#{Income.approved.count})")
        expect(page).to have_content("Pending (#{Income.pending.count})")
      end
    end
  end
end