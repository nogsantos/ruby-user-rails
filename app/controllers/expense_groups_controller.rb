class ExpenseGroupsController < ApplicationController
  before_action :set_expense_group, only: [:show, :update, :destroy]

  # GET /expense_groups
  def index
    @expense_groups = ExpenseGroup.all

    render json: @expense_groups
  end

  # GET /expense_groups/1
  def show
    render json: @expense_group
  end

  # POST /expense_groups
  def create
    @expense_group = ExpenseGroup.new(expense_group_params)

    if @expense_group.save
      render json: @expense_group, status: :created, location: @expense_group
    else
      render json: @expense_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /expense_groups/1
  def update
    if @expense_group.update(expense_group_params)
      render json: @expense_group
    else
      render json: @expense_group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /expense_groups/1
  def destroy
    @expense_group.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_group
      @expense_group = ExpenseGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def expense_group_params
      params.require(:expense_group).permit(:name, :status, :observation)
    end
end
