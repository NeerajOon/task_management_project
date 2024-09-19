class TasksController < ApplicationController
  before_action :authenticate_user_from_token!

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
      fix_task_deadline(@task)
      # render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      fix_task_deadline(@task)
    else
      render json: {message: "can not update"}, status: :unprocessable_entity
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

  def fix_task_deadline(task)
    return if task.done? 
    one_day_before = task.deadline - 1.day
    one_hour_before = task.deadline - 1.hour
    TaskDeadlineAlertJob.set(wait_until: one_day_before).perform_later(task) if one_day_before.future?
    TaskDeadlineAlertJob.set(wait_until: one_hour_before).perform_later(task) if one_hour_before.future?
  end
end
