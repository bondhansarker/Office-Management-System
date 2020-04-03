require 'rails_helper'

RSpec.describe LeavesController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @allocated_leafe = FactoryBot.create(:allocated_leafe, user: @user)
    @income = FactoryBot.create(:income, user: @user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index, params: {user_id: @user.id}
      expect(assigns(:leaves)).not_to be_nil
      expect(response).to render_template(:index)
      expect(response).to be_successful
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new, params: {user_id: @user.id}
      expect(assigns(:income)).to be_new_record
      expect(response).to render_template(:new)
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      @income = FactoryBot.build(:income)
      params = FactoryBot.attributes_for :income
      post :create, params: {user_id: @user.id, income: params}
      last_created_leafe = Leafe.last
      expect(last_created_leafe.start_date).to eq(@income.start_date)
      expect(last_created_leafe.end_date).to eq(@income.end_date)
      expect(last_created_leafe.reason).to eq(@income.reason)
      expect(last_created_leafe.leave_type).to eq(@income.leave_type)
      expect(response).to redirect_to(leaves_url)
      expect(flash[:notice]).to be_present
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      @income.pending!
      get :edit, params: {id: @income.id, user_id: @user.id}
      expect(assigns(:income)).not_to be_new_record
      expect(response).to render_template(:edit)
      expect(response).to be_successful
    end
  end

  describe "PUT 'update'" do
    it "should be successful" do
      @income.pending!
      put :update, params: {id: @income.id, income: {reason: "test reason"}}
      @income.reload
      expect(response).to redirect_to(show_all_allocated_leafe_url(@income.user.allocated_leafe))
      expect(@income.reason).to eq("test reason")
      expect(flash[:notice]).to eq("Leave information has been updated")
    end
  end

  describe "PUT 'Approve and Undo leafe'" do
    context "Approve" do
      it "should be successful" do
        @income.pending!
        put :approve, params: {id: @income.id}
        @income.reload
        expect(response).to redirect_to(show_all_allocated_leafe_url(@income.user.allocated_leafe))
        expect(@income.approved?).to eq(true)
        expect(flash[:notice]).to eq("The leave has been approved successfully")
      end
    end

    context "Undo" do
      it "should be successful" do
        put :approve, params: {id: @income.id}
        @income.reload
        expect(response).to redirect_to(show_all_allocated_leafe_url(@income.user.allocated_leafe))
        expect(@income.pending?).to eq(true)
        expect(flash[:notice]).to eq("Leave information has been changed successfully")
      end
    end
  end

  describe "PUT 'Reject'" do
    it "should be successful" do
      @income.pending!
      put :reject, params: {id: @income.id}
      @income.reload
      expect(response).to redirect_to(show_all_allocated_leafe_url(@income.user.allocated_leafe))
      expect(@income.rejected?).to eq(true)
      expect(flash[:notice]).to eq("The leave has been changed successfully")
    end
  end


end
