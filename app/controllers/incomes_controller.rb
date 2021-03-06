class IncomesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users_income = User.paginate(:page => params[:users_incomes], :per_page => Income::PER_PAGE)
    @users_bonus = @users_income.paginate(:page => params[:users_bonuses], :per_page => Income::PER_PAGE)

    @monthly_totals = Array.new(15,0)
    @all_incomes = []
    @all_bonuses = []
    @total_income_per_user = Array.new

    @users_income.each do |user|
      @temp_income = []
      @temp_bonus = []
      Income::MONTHS.each do |month|
        @temp_income << Income.find_incomes_by_months(user,month+1,params[:search])
        @temp_bonus << Income.bonus_amount(user,month+1,params[:search])
      end
      @all_incomes[user.id] = @temp_income
      @all_bonuses[user.id] = @temp_bonus
      @total_income_per_user[user.id] = Income.find_total(user,params[:search])
    end
  end

  def new

  end

  def create
    @income = current_user.incomes.new(income_params)
    if @income.save
      if current_user.admin? || current_user.super_admin?
        redirect_to incomes_path, notice: 'Your income has been created successfully'
      else
        redirect_to show_all_incomes_manage_user_path(@income.user), notice: 'Your income has been submitted for approval'
      end
    else
      render :new
    end

  end

  def edit

  end

  def update
    if @income.update(income_params)
      flash[:notice] = 'Your income information has been updated'
      redirect_to show_all_incomes_manage_user_path(@income.user)
    else
      render :edit
    end
  end

  def show

  end


  def destroy
    if @income && @income.destroy
    flash[:notice] = 'Your Income information has been destroyed'
    redirect_back(fallback_location: incomes_path)
    else
      flash[:alert] = 'Income could not be deleted!!'
      render :index
    end
  end

  def approve
    if @income.approved?
      @income.pending!
      flash[:notice] = 'The income status has been changed successfully'
    else
      @income.approved!
      flash[:notice] = 'Income has been approved'
    end
    redirect_back(fallback_location: incomes_path)
  end

  def reject
    @income.rejected!
    flash[:notice] = 'Income has been rejected'
    redirect_back(fallback_location: incomes_path)
  end


  private
  def income_params
    params.require(:income).permit(:user_id, :amount, :income_date, :source, :search)
  end

end
