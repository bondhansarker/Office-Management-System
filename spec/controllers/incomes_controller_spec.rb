require 'rails_helper'

RSpec.describe IncomesController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @income = FactoryBot.create(:income, user: @user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index, params: {user_id: @user.id}
      expect(assigns(:incomes)).not_to be_nil
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
      params = FactoryBot.attributes_for :income
      @income = FactoryBot.build(:income, income_date: params[:income_date])
      post :create, params: {user_id: @user.id, income: params}
      last_created_income = Income.last
      expect(last_created_income.amount).to eq(@income.amount)
      expect(last_created_income.income_date).to eq(@income.income_date)
      expect(last_created_income.source).to eq(@income.source)
      expect(response).to redirect_to(incomes_url)
      expect(flash[:notice]).to eq("Your income has been created successfully")
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
      put :update, params: {id: @income.id, income: {source: "test source"}}
      @income.reload
      expect(response).to redirect_to(show_all_incomes_manage_user_url(@income.user))
      expect(@income.source).to eq("test source")
      expect(flash[:notice]).to eq("Your income information has been updated")
    end
  end

  describe "PUT 'Approve and Undo leafe'" do
    context "Approve" do
      it "should be successful" do
        @income.pending!
        put :approve, params: {id: @income.id}
        @income.reload
        expect(response).to redirect_to(incomes_url)
        expect(@income.approved?).to eq(true)
        expect(flash[:notice]).to eq("Income has been approved")
      end
    end

    context "Undo" do
      it "should be successful" do
        put :approve, params: {id: @income.id}
        @income.reload
        expect(response).to redirect_to(incomes_url)
        expect(@income.pending?).to eq(true)
        expect(flash[:notice]).to eq("The income status has been changed successfully")
      end
    end
  end

  describe "PUT 'Reject'" do
    it "should be successful" do
      @income.pending!
      put :reject, params: {id: @income.id}
      @income.reload
      expect(response).to redirect_to(incomes_url)
      expect(@income.rejected?).to eq(true)
      expect(flash[:notice]).to eq("Income has been rejected")
    end
  end

end
