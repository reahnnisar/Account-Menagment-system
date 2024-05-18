class EntriesController < ApplicationController
  before_action :require_login

  def sum
    @total_sum = Entry.sum(:amount)
  end

  def index
    @entries = Entry.order(entry_date: :desc, created_at: :desc).all
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def new
    @entry = Entry.new(amount: 1)
  end

  def create
    @entry = Entry.new(entry_params)

    @entry.amount = -1 * @entry.amount if params[:direction].downcase == 'out'

    if @entry.save
      redirect_to entries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @entry = Entry.find(params[:id])
    @entry.amount = params[:entry][:amount]

    if params[:direction] == 'out'
       params[:entry][:amount] = -1 * @entry.amount
    elsif params[:direction] == 'in'
       params[:entry][:amount] = -1 * @entry.amount
    end


    if @entry.update(entry_params)

      redirect_to entries_path
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @entry = Entry.find(params[:id])

    @entry.destroy

    redirect_to root_path, status: :see_other
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  private
  def set_entry
    @entry = current_user.entries.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:entry_date, :amount, :description)
  end
end
