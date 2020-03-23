require 'rails_helper'

RSpec.describe Leafe, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @allocated_leafe = FactoryBot.create(:allocated_leafe, user: @user)
    @leafe = FactoryBot.build(:leafe, user: @user)
  end

  describe "Leafe" do
    it "should be created with valid attribute" do
      count = 0
      @leafe.save
      expect(@leafe.valid?).to eq(true)
      expect(count+1).to eq(Leafe.count)
    end
  end
end
