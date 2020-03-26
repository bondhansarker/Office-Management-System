require 'rails_helper'

RSpec.describe BudgetsController, type: :controller do
  before(:each) do
    @user = FactoryBot.build(:user)
    @category = FactoryBot.create(:category)
    @budget = FactoryBot.create(:budget, user: @user, category: @category)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      expect(assigns(:budgets)).not_to be_nil
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      expect(assigns(:budget)).to be_new_record
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      params = FactoryBot.attributes_for :budget
      params.merge!(category_id: @category.id, month:2)
      post :create, params: {budget: params}
      last_created_budget = Budget.last
      expect(last_created_budget.year).to eq(@budget.year)
      expect(last_created_budget.month).to eq(2)
      expect(last_created_budget.expense).to eq(@budget.expense)
      expect(last_created_budget.amount).to eq(@budget.amount)
      expect(response).to redirect_to(budgets_url)
      expect(flash[:notice]).to eq("Budget has been created successfully!!")
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get :edit, params: {id: @budget.id}
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "PUT 'update'" do
    it "should be successful" do
      put :update, params: {id: @budget.id, budget: {month: 10}}
      @budget.reload
      expect(response).to redirect_to(show_all_budgets_path(month: @budget.month, year: @budget.year))
      expect(@budget.month).to eq(10)
      expect(flash[:notice]).to eq("Budget has been updated successfully!!")
    end
  end

end
