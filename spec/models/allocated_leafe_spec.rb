require 'rails_helper'

RSpec.describe AllocatedLeafe, type: :model do

  before(:each) do
    @user = FactoryBot.create(:user)
    @allocated_leafe = FactoryBot.build(:allocated_leafe, user: @user)
  end

  describe "Create" do
    it "should be created with valid attribute" do
      count = 0
      @allocated_leafe.save
      expect(@allocated_leafe.valid?).to eq(true)
      expect(count+1).to eq(AllocatedLeafe.count)
    end
  end

  describe "method testing" do
    context "#allocated_leaves_count_for" do
      it "should return a hash of leave count based on leave type" do
        count = 0
        @allocated_leafe.save
        @leafe_1 = FactoryBot.create(:income, leave_type: Leafe::PL, user: @user)
        @leafe_2 = FactoryBot.create(:income, leave_type: Leafe::PL, user: @user)
        @leafe_3 = FactoryBot.create(:income, leave_type: Leafe::VL, user: @user)
        @leafe_4 = FactoryBot.create(:income, leave_type: Leafe::TL, user: @user)
        @leafe_5 = FactoryBot.create(:income, leave_type: Leafe::ML, user: @user)

        @leaves = @allocated_leafe.allocated_leaves_count_for(@user)
        expect(@leaves[:personal]).to eq(2)
        expect(@leaves[:training]).to eq(1)
        expect(@leaves[:vacation]).to eq(1)
        expect(@leaves[:medical]).to eq(1)

        expect(count+1).to eq(AllocatedLeafe.count)
      end
    end
  end

end
