require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.build(:user)
  end
  describe "User" do
    it "should not be created without email" do
      @user.email = nil
      @user.save
      expect(@user.valid?).to eq(false)
    end

    it "should not be created without name" do
      @user.name = nil
      @user.save
      expect(@user.valid?).to eq(false)
    end

    it "should not be created without phone" do
      @user.phone = nil
      @user.save
      expect(@user.valid?).to eq(false)
    end

    it "should not be created without target amount" do
      @user.target_amount = nil
      @user.save
      expect(@user.valid?).to eq(false)
    end

    it "should not be created without bonus percentage" do
      @user.bonus_percentage = nil
      @user.save
      expect(@user.valid?).to eq(false)
    end

    it "should be created with valid attribute" do

      count = 0
      @user.save
      expect(@user.valid?).to eq(true)
      expect(count+1).to eq(User.count)
    end
  end
end
