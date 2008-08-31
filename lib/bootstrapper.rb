class Bootstrapper
  class_inheritable_accessor :tasks
  write_inheritable_attribute :tasks, HashWithIndifferentAccess.new

  def self.for(key, &block)
    tasks[key] = block
  end

  def self.run(key)
    puts ">> Started executing bootstrap for #{key}"
    tasks[key].call(self)
    puts ">> Finished executing bootstrap for #{key}"
  end

  def self.truncate_tables(*tables)
    tables.each do |table|
      table.to_s.classify.constantize.delete_all
    end
  end
end
