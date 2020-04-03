require 'rails_helper'

RSpec.feature "Categories", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    login_as(@user, :scope => :user)
  end

  describe "Create" do
    it "should be successful" do
      visit(root_url)
      click_on 'Budget'
      click_on 'Add new Category'
      expect(current_url).to eq(new_category_url)
      expect(find(:css, "h1").text).to eq("Insert Budget Category")
      within('form') do
        fill_in 'category_name', with: 'Test Category form'
      end
      click_on 'Submit'
      expect(page).to have_content("Category for Budget has been created successfully!!")
      expect(current_url).to eq(categories_url)
      expect(find(:css, "h1").text).to eq("Budget Categories")
      expect(2).to eq(Category.count)
      expect(page).to have_content("Test Category form")
    end
  end

  context "Destroy" do
    it "should be successful" do
      visit(categories_url)
      expect(current_url).to eq(categories_url)
      expect(find(:css, "h1").text).to eq("Budget Categories")
      expect(page).to have_content(@category_name)
      expect(1).to eq(Category.count)
      within('.table') do
        page.find('.destroy_link').click
      end
      expect(current_url).to eq(categories_url)
      expect(0).to eq(Category.count)
    end
  end

  context "Update" do
    it "should be successful" do
      visit(categories_url)
      expect(current_url).to eq(categories_url)
      expect(find(:css, "h1").text).to eq("Budget Categories")
      within('.table') do
        page.find('.edit_link').click
      end
      expect(page).to have_content("Edit Budget Category")
      within('form') do
        fill_in 'category_name', with: 'Test Update Category form'
      end
      click_on 'Submit'
      expect(page).to have_content("Category for Budget has been updated successfully!!")
      expect(current_url).to eq(categories_url)
      expect(find(:css, "h1").text).to eq("Budget Categories")
      expect(page).to have_content("Test Update Category form")
      expect(Category.last.name).to eq("Test Update Category form")
    end
  end
end