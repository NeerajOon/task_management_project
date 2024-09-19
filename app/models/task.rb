class Task < ApplicationRecord
  belongs_to :user
  enum status: { backlog: 0, in_progress: 1, done: 2 }
end
