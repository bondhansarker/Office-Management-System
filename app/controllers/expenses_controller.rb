class ExpensesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @expenses = @expenses.includes(:user)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @expenses = @expenses.where('users.name ilike :search OR product_name ilike :search', {search: search})
    end
    @expenses = @expenses.where('expense_date BETWEEN :from AND :to', {from: params[:from], to: params[:to]}) if params[:from].present? and params[:to].present?
    @expenses = @expenses.sort_by_attr(:expense_date)
    @pending_expenses = @expenses.pending.paginate(:page => params[:pending_expenses], :per_page => Expense::PER_PAGE)
    @approved_expenses = @expenses.approved.paginate(:page => params[:approved_expenses], :per_page => Expense::PER_PAGE)
    @rejected_expenses = @expenses.rejected.paginate(:page => params[:rejected_expenses], :per_page => Expense::PER_PAGE)
  end

  def new

  end

  def create
    @expense = current_user.expenses.new(expense_params)
    if @expense.save
      redirect_to expenses_path, success: 'Expense has been created successfully!!'
    else
      render :new
    end
  end

  def show

  end

  def destroy
    if @expense && @expense.destroy
      flash[:alert] = 'Expense has been removed successfully!!'
    else
      flash[:alert] = 'Expense could not be deleted!!'
    end
    redirect_back(fallback_location: expenses_path)
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, success: 'Expense has been updated successfully!!'
    else
      render :edit
    end
  end

  def reject
    @expense.rejected!
    redirect_back(fallback_location: expenses_path, alert: 'Expense has been rejected successfully!!')
  end

  def approve
    if @expense.approved?
      @expense.pending!
      flash[:warning] = 'The Expense has been queued for pending!!'
    else
      @expense.approved!
      flash[:notice] = 'Expense has been approved successfully!!'
    end
    @expense.update_budget
    redirect_back(fallback_location: expenses_path)
  end


  private
  def expense_params
    params.require(:expense).permit(:product_name, :category, :cost, :details, :image, :expense_date)
  end

end
