require 'rails_helper'

RSpec.describe AllocatedLeavesController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    @allocated_leafe = FactoryBot.create(:allocated_leafe, user: @user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      expect(assigns(:allocated_leaves)).not_to be_nil
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      expect(assigns(:allocated_leafe)).to be_new_record
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      params = FactoryBot.attributes_for :allocated_leafe
      params.update({year:2022})
      params.merge!(user_id: @user.id)
      post :create, params: {allocated_leafe: params}
      last_created_budget = AllocatedLeafe.last
      expect(last_created_budget.year).to eq("2022")
      expect(last_created_budget.user.name).to eq(@user.name)
      expect(last_created_budget.total_leave).to eq(@allocated_leafe.total_leave)
      expect(response).to redirect_to(allocated_leaves_path)
      expect(flash[:notice]).to eq("Leave has been allocated successfully")
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get :edit, params: {id: @allocated_leafe.id}
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "PUT 'update'" do
    it "should be successful" do
      put :update, params: {id: @allocated_leafe.id, allocated_leafe: {total_leave: 100}}
      @allocated_leafe.reload
      expect(response).to redirect_to(allocated_leaves_path)
      expect(@allocated_leafe.total_leave).to eq(100)
      expect(flash[:notice]).to eq("Your information has been updated successfully")
    end
  end
end
