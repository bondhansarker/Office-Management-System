require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @category = FactoryBot.create(:category)
  end
  describe "Category" do
    it "should be created with valid attribute" do
      count = 0
      @category.save
      expect(@category.valid?).to eq(true)
      expect(count+1).to eq(Category.count)
    end
  end
end
