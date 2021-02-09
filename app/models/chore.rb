class Chore < ApplicationRecord
	belongs_to :child
	belongs_to :task

	validates_date :due_on

	#scopes

	scope :by_task, -> { joins(:task).order('tasks.name') }
	scope :chronological, -> { order('due_on') }
	scope :pending, -> { where('completed = ?', false) }
	scope :done, -> { where('completed  = ?', true) }
	scope :upcoming, -> { where('due_on >= ?', Date.today) }
	scope :past, -> { where('due_on < ?', Date.today) }

	def status
		self.completed ? "Completed" : "Pending"
	end
end
