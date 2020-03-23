require 'rails_helper'

RSpec.describe Income, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @income = FactoryBot.build(:income, user: @user)
  end

  describe "Income" do
    it "should be created with valid attribute" do
      count = 0
      @income.save
      expect(@income.valid?).to eq(true)
      expect(count+1).to eq(Income.count)
    end
  end
end
