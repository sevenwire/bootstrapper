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
      ActiveRecord::Base.connection.truncate_table(table)
    end
  end

  def self.fixtures(*fixtures)
    Fixtures.create_fixtures(File.join(RAILS_ROOT, 'db', 'populate'), fixtures)

  end

  def self.sql(sql)
    ActiveRecord::Base.connection.execute(sql)
  end
end
