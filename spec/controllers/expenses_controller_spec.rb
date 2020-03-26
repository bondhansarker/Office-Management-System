require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do

  before(:each) do
    @user = FactoryBot.build(:user)
    @category = FactoryBot.create(:category)
    @budget = FactoryBot.create(:budget, user: @user, category: @category)
    @expense = FactoryBot.create(:expense, user: @user, category: @category)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      expect(assigns(:expenses)).not_to be_nil
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      expect(assigns(:expense)).to be_new_record
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      params = FactoryBot.attributes_for :expense
      params.merge!(category_id: @category.id)
      post :create, params: {expense: params}
      last_created_expense = Expense.last
      expect(last_created_expense.product_name).to eq(@expense.product_name)
      expect(last_created_expense.expense_date).to eq(@expense.expense_date)
      expect(last_created_expense.cost).to eq(@expense.cost)
      expect(last_created_expense.category).to eq(@expense.category)
      expect(response).to redirect_to(expenses_path)
      expect(flash[:notice]).to eq("Expense has been created successfully!!")
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      @expense.pending!
      get :edit, params: {id: @expense.id}
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "PUT 'update'" do
    it "should be successful" do
      @expense.pending!
      put :update, params: {id: @expense.id, expense: {product_name: "test expense"}}
      @expense.reload
      expect(response).to redirect_to(expenses_url)
      expect(@expense.product_name).to eq("test expense")
      expect(flash[:notice]).to eq("Expense has been updated successfully!!")
    end
  end

  describe "PUT 'Approve and Undo expense'" do
    context "Approve" do
      it "should be successful" do
        @expense.pending!
        put :approve, params: {id: @expense.id}
        @expense.reload
        expect(response).to redirect_to(expenses_url)
        expect(@expense.approved?).to eq(true)
        expect(flash[:notice]).to eq("Expense has been approved successfully!!")
      end
    end

    context "Undo" do
      it "should be successful" do
        put :approve, params: {id: @expense.id}
        @expense.reload
        expect(response).to redirect_to(expenses_url)
        expect(@expense.pending?).to eq(true)
        expect(flash[:warning]).to eq("The Expense has been queued for pending!!")
      end
    end
  end

  describe "PUT 'Reject'" do
    it "should be successful" do
      @expense.pending!
      put :reject, params: {id: @expense.id}
      @expense.reload
      expect(response).to redirect_to(expenses_url)
      expect(@expense.rejected?).to eq(true)
      expect(flash[:alert]).to eq("Expense has been rejected successfully!!")
    end
  end

end
