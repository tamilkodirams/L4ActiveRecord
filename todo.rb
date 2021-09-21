require "active_record"

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    puts "#{id} #{display_status} #{todo_text} #{display_date}"
  end

  def self.show_list
    puts "My Todo-List\n\n"
    puts "Overdue\n"
    record = Todo.where("DATE(due_date) < DATE(?)", Date.today)
    record.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    puts "Due Today\n"
    record = Todo.where(due_date: Date.today)
    record.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    puts "Due Later\n"
    record = Todo.where("DATE(due_date) > DATE(?)", Date.today)
    record.map { |todo| todo.to_displayable_string }
  end
  def self.add_task(h)
    puts "In add_task"
    puts h[:todo_text]
    puts h[:due_in_days]
    Todo.create!(todo_text: h[:todo_text], due_date: Date.today + h[:due_in_days], completed: false)
  end
  def self.mark_as_complete(todo_id)
    record = Todo.find_by(id: todo_id)
    record.update(completed: true)
  end
end
