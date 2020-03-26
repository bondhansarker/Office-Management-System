require 'rails_helper'

RSpec.describe LeavesController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @allocated_leafe = FactoryBot.create(:allocated_leafe, user: @user)
    @leafe = FactoryBot.create(:leafe, user: @user)
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
      expect(assigns(:leafe)).to be_new_record
      expect(response).to render_template(:new)
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      @leafe = FactoryBot.build(:leafe)
      params = FactoryBot.attributes_for :leafe
      post :create, params: {user_id: @user.id, leafe: params}
      last_created_leafe = Leafe.last
      expect(last_created_leafe.start_date).to eq(@leafe.start_date)
      expect(last_created_leafe.end_date).to eq(@leafe.end_date)
      expect(last_created_leafe.reason).to eq(@leafe.reason)
      expect(last_created_leafe.leave_type).to eq(@leafe.leave_type)
      expect(response).to redirect_to(leaves_url)
      expect(flash[:notice]).to be_present
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      @leafe.pending!
      get :edit, params: {id: @leafe.id, user_id: @user.id}
      expect(assigns(:leafe)).not_to be_new_record
      expect(response).to render_template(:edit)
      expect(response).to be_successful
    end
  end

  describe "PUT 'update'" do
    it "should be successful" do
      @leafe.pending!
      put :update, params: {id: @leafe.id, leafe: {reason: "test reason"}}
      @leafe.reload
      expect(response).to redirect_to(show_all_allocated_leafe_url(@leafe.user.allocated_leafe))
      expect(@leafe.reason).to eq("test reason")
      expect(flash[:notice]).to eq("Leave information has been updated")
    end
  end

  describe "PUT 'Approve and Undo leafe'" do
    context "Approve" do
      it "should be successful" do
        @leafe.pending!
        put :approve, params: {id: @leafe.id}
        @leafe.reload
        expect(response).to redirect_to(show_all_allocated_leafe_url(@leafe.user.allocated_leafe))
        expect(@leafe.approved?).to eq(true)
        expect(flash[:notice]).to eq("The leave has been approved successfully")
      end
    end

    context "Undo" do
      it "should be successful" do
        put :approve, params: {id: @leafe.id}
        @leafe.reload
        expect(response).to redirect_to(show_all_allocated_leafe_url(@leafe.user.allocated_leafe))
        expect(@leafe.pending?).to eq(true)
        expect(flash[:notice]).to eq("Leave information has been changed successfully")
      end
    end
  end

  describe "PUT 'Reject'" do
    it "should be successful" do
      @leafe.pending!
      put :reject, params: {id: @leafe.id}
      @leafe.reload
      expect(response).to redirect_to(show_all_allocated_leafe_url(@leafe.user.allocated_leafe))
      expect(@leafe.rejected?).to eq(true)
      expect(flash[:notice]).to eq("The leave has been changed successfully")
    end
  end


end
