class BudgetsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    if params[:search]
      @budgets = Budget.search(params[:search]).order('budgets.id ASC').paginate(:page => params[:page], :per_page => 12) #raise @budgets.to_sql
    else
      @budgets = Budget.order('budgets.id ASC').paginate(:page => params[:page], :per_page => 12)
    end
  end

  def new
    @budget=Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.user_id = current_user.id
    if @budget.save
      redirect_to budgets_path, notice: "Budget has been created successfully"
    else
      render 'new'
    end
  end

  def show
    @approved_expenses = Expense.status_expenses(params[:search], params[:page], params[:id],params[:status]='Approved')
    @pending_expenses = Expense.status_expenses(params[:search], params[:page], params[:id],params[:status]='Pending')
    @rejected_expenses = Expense.status_expenses(params[:search], params[:page], params[:id],params[:status]='Rejected')
    @total=Expense.where(budget_id: params[:id], status: 'Approved').sum(:cost)
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy
    redirect_to budgets_path, notice: "Budget has been removed successfully"
  end

  def edit
    @budget = Budget.find(params[:id])
    @budget.year=@budget.month.chars.last(4).join
    @budget.month=@budget.month[0...-6]
  end

  def update
    @budget = Budget.find(params[:id])
    if @budget.update(budget_params)
      redirect_to budget_path, notice: "Budget has been updated successfully"
    else
      render 'edit'
    end
  end

  private
  def budget_params
    params.require(:budget).permit(:year, :month, :amount ,:add)
  end

end