require 'rails_helper'

RSpec.describe Budget, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    @budget = FactoryBot.create(:budget, user: @user, category: @category)
  end

  describe "Budget" do
    it "should be created with valid attribute" do
      count = 0
      @budget.save
      expect(@budget.valid?).to eq(true)
      expect(count+1).to eq(Budget.count)
    end
  end

  describe "Budget" do
    it "should be created with unique month and year and category" do
      count = 0
      @budget.save
      expect(@budget.valid?).to eq(true)
      expect(count+1).to eq(Budget.count)

      duplicate = FactoryBot.build(:budget, user: @user, category: @category)
      duplicate.save
      expect(duplicate.valid?).to eq(false)
      expect(duplicate.errors.full_messages.include?("Month has already been taken")).to eq(true)
      expect(count+1).to eq(Budget.count)

      different_month = FactoryBot.build(:budget, user: @user, category: @category)
      different_month.month = 2
      different_month.save
      expect(different_month.valid?).to eq(true)
      expect(count+2).to eq(Budget.count)

      differnt_year = FactoryBot.build(:budget, user: @user, category: @category)
      differnt_year.year = 2021
      differnt_year.save
      expect(differnt_year.valid?).to eq(true)
      expect(count+3).to eq(Budget.count)

      unique_category = FactoryBot.build(:category)
      unique_category.name = "unique"
      differnt_category = FactoryBot.build(:budget, user: @user, category: unique_category)
      differnt_category.save
      expect(differnt_category.valid?).to eq(true)
      expect(count+4).to eq(Budget.count)
    end
  end

end
