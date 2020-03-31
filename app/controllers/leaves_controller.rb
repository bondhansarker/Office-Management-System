class LeavesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @leaves = @leaves.includes(:user)
    if params[:search].present?
      search = "%#{params[:search]}%"
      @leaves = @leaves.joins(:user).where('users.name ilike :search OR leave_type ilike :search', {search: search})
    end

    @leaves = @leaves.where(':from <= end_date ', {from: params[:from]}) if params[:from].present?
    @leaves = @leaves.where(':to >= start_date ', {to: params[:to]}) if params[:to].present?

    @leaves_pending = @leaves.pending.paginate(:page => params[:pending_leaves], :per_page => Leafe::PER_PAGE)
    @leaves_approved = @leaves.approved.paginate(:page => params[:approved_leaves], :per_page => Leafe::PER_PAGE)
    @leaves_rejected = @leaves.rejected.paginate(:page => params[:rejected_leaves], :per_page => Leafe::PER_PAGE)
  end

  def new
    @leafe = current_user.leaves.new
  end

  def create
    @leafe = current_user.leaves.new(leafe_params)
    if @leafe.user.allocated_leafe.present?
      days = Leafe.count_days(@leafe.start_date, @leafe.end_date)
      if days > 0 && @leafe.check_validity_of_leave(days)
        if @leafe.save
          if current_user.admin? || current_user.super_admin?
            flash[:notice] = 'Your leave application has been created successfully'
          else
            flash[:notice] = 'Your leave application has been submitted for approval'
          end
          redirect_to leaves_path
        else
          render :new
        end
      else
        flash[:warning] = 'Please select a valid date range!!'
        render :new
      end
    else
      flash[:warning] = 'Your leave has not been allocated yet'
      render :new
    end

  end

  def edit

  end

  def show

  end

  def update
    if @leafe.update(leafe_params)
      flash[:notice] = 'Leave information has been updated'
      if current_user.admin? || current_user.super_admin?
        redirect_to show_all_allocated_leafe_path(@leafe.user.allocated_leafe)
      else
        redirect_to leaves_path
      end
    else
      render :edit
    end
  end

  def destroy
    user = @leafe.user
    if @leafe && @leafe.destroy
      flash[:notice] = 'Information has heen destroyed'
      if current_user.admin? || current_user.super_admin?
        redirect_to show_all_allocated_leafe_path(user.allocated_leafe)
      else
        redirect_to leaves_path
      end
    else
      flash[:alert] = 'Leave could not be deleted!!'
      render :index
    end
  end

  def approve
    if @leafe.user.allocated_leafe
      if @leafe.approved?
        @leafe.pending!
        flash[:notice] = 'Leave information has been changed successfully'
      else
        @leafe.approved!
        #LeafeMailer.approved(@leafe).deliver_now
        flash[:notice] = 'The leave has been approved successfully'
      end
      @leafe.update_allocated_leave
      redirect_to show_all_allocated_leafe_path(@leafe.user.allocated_leafe)
    else
      redirect_to leaves_path, alert: 'Leave for this user has not been allocated yet.'
    end
  end

  def reject
    @leafe.rejected!
    #LeafeMailer.rejected(@leafe).deliver_now
    redirect_to show_all_allocated_leafe_path(@leafe.user.allocated_leafe), notice: 'The leave has been changed successfully'
  end

  private
  def leafe_params
    params.require(:leafe).permit(:start_date, :end_date, :reason, :leave_type, :status)
  end


end
