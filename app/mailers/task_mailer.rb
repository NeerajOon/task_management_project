class TaskMailer < ApplicationMailer
	def deadline_reminder(task)
		@task = task
		mail(to: @task.user.email, subject: "Task Deadline Reminder")
	end
end
