require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @category = FactoryBot.build(:category)
  end
  describe "Category" do
    it "should be created with valid attribute" do
      count = 0
      @category.save
      expect(@category.valid?).to eq(true)
      expect(count+1).to eq(Category.count)
    end
  end

  describe "Category" do
    it "should be created with unique name" do
      count = 0
      @category.save
      duplicate_category = FactoryBot.build(:category)
      duplicate_category.save
      expect(duplicate_category.valid?).to eq(false)
      expect(duplicate_category.errors.full_messages.include?("Name has already been taken")).to eq(true)
      expect(count+1).to eq(Category.count)
    end
  end

  describe "Category" do
    it "should be created with name" do
      count = 0
      @category.name = ""
      @category.save
      expect(@category.valid?).to eq(false)
      expect(@category.errors.full_messages.include?("Name can't be blank")).to eq(true)
      expect(count).to eq(Category.count)
    end
  end
end
