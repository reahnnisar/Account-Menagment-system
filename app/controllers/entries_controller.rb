class EntriesController < ApplicationController

  before_action :require_login
  def sum
    @total_sum = current_user.entries.sum(:amount)
  end

  def index
    @entries = current_user.entries.order(entry_date: :desc, created_at: :desc)
  end

  def show
    @entry = current_user.entries.find(params[:id])
  end

  def new
    @entry = current_user.entries.new(amount: 1)
  end

  def create
    @entry = current_user.entries.new(entry_params)

    @entry.amount = -1 * @entry.amount if params[:direction].downcase == 'out'

    if @entry.save
      redirect_to entries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @entry = current_user.entries.find(params[:id])

    if params[:direction].downcase == 'out'
      @entry.amount = -1 * entry_params[:amount].to_i
    else
      @entry.amount = entry_params[:amount].to_i
    end

    if @entry.update(entry_params)
      redirect_to entries_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry = current_user.entries.find(params[:id])
    @entry.destroy
    redirect_to root_path, status: :see_other
  end

  def edit
    @entry = current_user.entries.find(params[:id])
  end

  private

  def entry_params
    params.require(:entry).permit(:entry_date, :amount, :description).merge(user: current_user)
  end
end
