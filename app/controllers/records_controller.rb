class RecordsController < ApplicationController
def index
    if params[:user_id].present?
      @records = User.find(params[:user_id]).records
    else
      @records = Record.all
    end
  end

  def new
    @record = Record.new
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])

    if @record.update_attributes(user_params)
      flash[:notice] = "Record updated!"
      redirect_to record_path(@record)
    else
      flash[:notice] = "Failed to update record"
      redirect_to edit_record_path(@record)
    end

  end

  def create
    @record = current_user.records.create( record_params )

    if @record 
      flash[:alert] = "Record created successfully!"
      redirect_to record_path(@record) 
    else
      flash[:alert] = "Oops! Something went wrong!"
      redirect_to new_record_path
    end
  end

  def destroy
      @record = Record.find(params[:id])
    if @record.destroy
      flash[:notice] = "Record deleted successfully."
    else
      flash[:alert] = "There was a problem."
    end
    redirect_to new_record_path
  end

  def show
    @record = Record.find(params[:id])
  end

  private
  def record_params
    params.require(:record).
      permit(:record_title, :record_date, :record_type, :record_notes)
  end

end
