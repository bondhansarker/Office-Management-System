require 'rails_helper'

RSpec.feature "AllocatedLeaves", type: :feature do
  before(:each) do
    @admin = FactoryBot.create(:user)
    @admin.save
    @user = FactoryBot.create(:user)
    @user.role = 'Employee'
    @user.save
    @allocated_leafe = FactoryBot.create(:allocated_leafe, user: @admin)
    login_as(@admin, :scope => :user)
  end

  describe "Create" do
    it "should be successful" do
      visit(root_url)
      click_on 'Leave'
      click_on 'Appointed Leaves'
      expect(current_url).to eq(allocated_leaves_url)
      expect(find(:css, "h1").text).to have_content("List of Leave of Year : #{Date.today.year}")
      click_on 'Appoint Leave'
      expect(current_url).to eq(new_allocated_leafe_url)
      expect(find(:css, "h1").text).to have_content("Allocate Leave")
      within('form') do
        select("#{@user.name}", from: 'allocated_leafe_user_id')
        select("#{Date.today.year}", from: 'allocated_leafe_year')
        fill_in 'allocated_leafe_total_leave', with: 30
      end
      click_on 'Save'
      expect(current_url).to eq(allocated_leaves_url)
      expect(2).to eq(AllocatedLeafe.count)
      expect(find(:css, "h1").text).to have_content("List of Leave of Year : #{Date.today.year}")
    end
  end

  describe "Show" do
    context "Pending" do
      it "should be successful" do
        visit(root_url)
        click_on 'Leave'
        click_on 'Appointed Leaves'
        expect(current_url).to eq(allocated_leaves_url)
        expect(find(:css, "h1").text).to have_content("List of Leave of Year : #{Date.today.year}")

        within('.table-responsive-sm') do
          page.find('.show_link').click
        end
        expect(find(:css, "h1").text).to eq("Details")

        within('#allocated_leave_card') do
          expect(page).to have_content(@admin.name)
        end

        within('#leave_card') do
          expect(page).to have_content("Personal Leaves")
          expect(page).to have_content("Training Leaves")
          expect(page).to have_content("Vacation Leaves")
          expect(page).to have_content("Medical Leaves")
        end
        page.find('.btn-dark').click
        expect(current_url).to eq(allocated_leaves_url)
      end
    end
  end

  context "Destroy" do
    it "should be successful" do
      visit(root_url)
      click_on 'Leave'
      click_on 'Appointed Leaves'
      expect(current_url).to eq(allocated_leaves_url)
      expect(find(:css, "h1").text).to have_content("List of Leave of Year : #{Date.today.year}")
      within('.table-responsive-sm') do
        page.find('.destroy_link').click
      end
      expect(page).to have_content("Information has been removed")
      expect(0).to eq(AllocatedLeafe.count)
      expect(current_url).to eq(allocated_leaves_url)
    end
  end

  context "Update" do
    it "should be successful" do
      visit(root_url)
      click_on 'Leave'
      click_on 'Appointed Leaves'
      expect(current_url).to eq(allocated_leaves_url)
      expect(find(:css, "h1").text).to have_content("List of Leave of Year : #{Date.today.year}")
      within('.table-responsive-sm') do
        page.find('.edit_link').click
      end
      expect(current_url).to eq(edit_allocated_leafe_url(@admin.allocated_leafe))
      expect(find(:css, "h1").text).to eq("Edit")
      expect(find(:css, "h3").text).to eq("User: #{@admin.name}")
      within('form') do
        fill_in 'allocated_leafe_total_leave', with: 40
      end
      click_on 'Update'
      expect(current_url).to eq(allocated_leaves_url)
      expect(AllocatedLeafe.last.total_leave).to eq(40)

    end
  end

  context "Show All" do
    it "should be successful" do
      visit(root_url)
      click_on 'Leave'
      click_on 'Appointed Leaves'
      expect(current_url).to eq(allocated_leaves_url)
      expect(find(:css, "h1").text).to have_content("List of Leave of Year : #{Date.today.year}")
      within('.table-responsive-sm') do
        click_on "#{@admin.name}"
      end
      expect(current_url).to eq(show_all_allocated_leafe_url(@admin.allocated_leafe))
      expect(find(:css, "h1").text).to eq("List of Leaves of #{@admin.name}")
      expect(page).to have_content("Pending (#{@admin.leaves.pending.count})")
      expect(page).to have_content("Approved (#{@admin.leaves.approved.count})")
      expect(page).to have_content("Rejected (#{@admin.leaves.rejected.count})")
      click_on 'Back'
      expect(current_url).to eq(allocated_leaves_url)
    end
  end
end
