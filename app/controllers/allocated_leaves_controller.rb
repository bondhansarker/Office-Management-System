class AllocatedLeavesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource


  def index
    @allocated_leaves = AllocatedLeafe.order('id ASC').paginate(:page => params[:page], :per_page => 3)
    #raise @attendance.inspect
  end

  def new
    @allocated_leave = AllocatedLeafe.new
  end

  def create
    @allocated_leave = AllocatedLeafe.new(allocated_leafe_params)
    @allocated_leave.used_leave = 0
    if @allocated_leave.save
    redirect_to allocated_leaves_path, notice: "Leave Information has been Created Successfully!!"
    else
      render 'new'
    end
  end

  def edit
    @allocated_leave = AllocatedLeafe.find(params[:id])
  end

  def show
    @allocated_leave = AllocatedLeafe.find(params[:id])
  end

  def update
    @allocated_leave = AllocatedLeafe.find(params[:id])
    @allocated_leave.update(allocated_leafe_params)
    redirect_to allocated_leaves_path, notice: "Your Information has been Updated Successfully!!"
  end

  def destroy
    @allocated_leave = AllocatedLeafe.find(params[:id])
    @allocated_leave.destroy
    redirect_to allocated_leaves_path, alert: "Information has been Removed!!"
  end

  def show_all
    @allocated_leave = AllocatedLeafe.find(params[:id])
    @leaves_pending = Leafe.where(user_id: @allocated_leave.user_id, status: 'Pending').order('id ASC').paginate(:page => params[:page], :per_page => 3)
    @leaves_approved = Leafe.where(user_id: @allocated_leave.user_id, status: 'Approved').order('id ASC').paginate(:page => params[:page], :per_page => 3)
    @leaves_rejected = Leafe.where(user_id: @allocated_leave.user_id, status: 'Rejected').order('id ASC').paginate(:page => params[:page], :per_page => 3)
    #raise @leaves.inspect
  end

  private
  def allocated_leafe_params
    params.require(:allocated_leafe).permit(:user_id, :total_leave )
  end



end
