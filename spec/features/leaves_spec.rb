require 'rails_helper'

RSpec.feature "Leaves", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
    @user.role = "Employee"
    @user.save
    @allocated_leafe = FactoryBot.create(:allocated_leafe, user: @user)
    @leafe = FactoryBot.create(:leafe, user: @user)
    login_as(@user, :scope => :user)
  end

  describe "Create" do
    it "should be successful" do
      visit(root_url)
      click_on 'Leave'
      click_on 'Apply for Leave'
      expect(current_url).to eq(new_leafe_url)
      expect(find(:css, "h1").text).to eq("Apply for Leave")
      within('form') do
        fill_in 'datepicker', with: '2020-01-01'
        fill_in 'datepicker2', with: '2020-01-03'
        fill_in 'leafe_reason', with: 'Test Reason'
      end
      click_on 'Save'
      expect(page).to have_content("Your leave application has been submitted for approval")
      expect(current_url).to eq(leaves_url)
      expect(find(:css, "h1").text).to eq("All Leave Requests")
      expect(2).to eq(Leafe.count)
      expect(page).to have_content("Pending (#{Leafe.pending.count})")
    end
  end


  describe "Show" do
    context "Pending" do
      it "should be successful" do
        visit(leaves_url)
        expect(current_url).to eq(leaves_url)
        expect(find(:css, "h1").text).to eq("All Leave Requests")
        expect(page).to have_content("Pending (#{Leafe.pending.count})")
        expect(page).to have_content(@leafe.user.name)
        within('#pending') do
          page.find('.show_link').click
        end
        within('.col-md-5') do
          expect(page).to have_content(@leafe.user.name)
          expect(page).to have_content("Pending")
          expect(page).to have_content(@leafe.reason)
          expect(current_url).to eq(leafe_url(@leafe))
        end
        page.find('.btn-dark').click
        expect(current_url).to eq(leaves_url)
      end
    end
  end

  context "Destroy" do
    it "should be successful" do
      visit(leaves_url)
      expect(current_url).to eq(leaves_url)
      expect(find(:css, "h1").text).to eq("All Leave Requests")
      expect(page).to have_content("Pending (#{Leafe.pending.count})")
      expect(page).to have_content(@leafe.user.name)
      expect(1).to eq(Leafe.count)
      within('#pending') do
        page.find('.destroy_link').click
      end
      expect(current_url).to eq(leaves_url)
      expect(0).to eq(Leafe.count)
      expect(page).to have_content("Pending (#{Leafe.pending.count})")
    end
  end

  context "Update" do
    it "should be successful" do
      visit(leaves_url)
      expect(current_url).to eq(leaves_url)
      expect(find(:css, "h1").text).to eq("All Leave Requests")
      expect(page).to have_content("Pending (#{Leafe.pending.count})")
      expect(page).to have_content(@leafe.user.name)
      expect(1).to eq(Leafe.count)
      within('#pending') do
        page.find('.edit_link').click
      end
      expect(page).to have_content("Edit")
      expect(page).to have_content("User: #{@leafe.user.name}")
      within('form') do
        fill_in 'leafe_reason', with: 'Test Reason Updated'
      end
      click_on 'Update'
      expect(page).to have_content("Leave information has been updated")
      expect(current_url).to eq(leaves_url)
      expect(find(:css, "h1").text).to eq("All Leave Requests")
      expect(Leafe.last.reason).to eq("Test Reason Updated")
    end
  end

  context "Reject" do
    it "should be successful" do
      @admin_user = FactoryBot.create(:user)
      @admin_user.role = "Admin"
      @admin_user.save
      login_as(@admin_user, :scope => :user)
      visit(root_url)
      click_on 'Leave'
      click_on 'Leave Requests'
      expect(current_url).to eq(leaves_url)
      expect(find(:css, "h1").text).to eq("All Leave Requests")
      expect(0).to eq(Leafe.rejected.count)
      expect(1).to eq(Leafe.pending.count)
      within('#pending') do
        page.find('.reject_link').click
      end
      expect(page).to have_content("The leave has been changed successfully")
      expect(current_url).to eq(show_all_allocated_leafe_url(@user.allocated_leafe))
      expect(1).to eq(Leafe.rejected.count)
      expect(0).to eq(Leafe.pending.count)
      expect(page).to have_content("Rejected (#{Leafe.rejected.count})")
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
        click_on 'Leave'
        click_on 'Leave Requests'
        expect(current_url).to eq(leaves_url)
        expect(find(:css, "h1").text).to eq("All Leave Requests")
        expect(0).to eq(Leafe.approved.count)
        expect(1).to eq(Leafe.pending.count)

        within('#pending') do
          page.find('.approve_link').click
        end
        expect(page).to have_content("The leave has been approved successfully")
        expect(current_url).to eq(show_all_allocated_leafe_url(@leafe.user.allocated_leafe))

        expect(0).to eq(Leafe.pending.count)
        expect(1).to eq(Leafe.approved.count)
        expect(page).to have_content("Approved (#{Leafe.approved.count})")
        expect(page).to have_content("Pending (#{Leafe.pending.count})")
      end
    end

    context "Undo" do
      it "should be successful" do
        @admin_user = FactoryBot.create(:user)
        @admin_user.role = "Admin"
        @admin_user.save
        login_as(@admin_user, :scope => :user)
        @leafe.approved!
        visit(root_url)
        click_on 'Leave'
        click_on 'Leave Requests'
        expect(current_url).to eq(leaves_url)
        expect(find(:css, "h1").text).to eq("All Leave Requests")
        expect(1).to eq(Leafe.approved.count)
        expect(0).to eq(Leafe.pending.count)

        within('#approved') do
          page.find('.undo_link').click
        end
        expect(page).to have_content("Leave information has been changed successfully")
        expect(current_url).to eq(show_all_allocated_leafe_url(@leafe.user.allocated_leafe))
        expect(1).to eq(Leafe.pending.count)
        expect(0).to eq(Leafe.approved.count)
        expect(page).to have_content("Approved (#{Leafe.approved.count})")
        expect(page).to have_content("Pending (#{Leafe.pending.count})")
      end
    end
  end
end