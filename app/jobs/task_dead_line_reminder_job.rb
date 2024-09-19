class TaskDeadLineReminderJob < ApplicationJob
  queue_as :default

  def perform(task)

    return if task.done?  
    TaskMailer.with(task: task).deadline_reminder.deliver_now
  end
end
