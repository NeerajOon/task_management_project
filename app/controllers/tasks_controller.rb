class TasksController < ApplicationController
  before_action :authenticate_user!

  def index 
    @tasks = current_user.tasks 
    render json: @tasks
  end 

  def show 
    @task = current_user.tasks.find(params[:id])
  end 

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
    else
    end
  end

  def destroy 
    @task = current_user.tasks.find(params[:id])
    if @task.destroy
      render json: {message: "task deleted successfully."}
    else 
      render json: {error: @task.errors.full_messages }, status: :unprocessable_entity
    end 
  end 
  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :deadline)
  end
end
