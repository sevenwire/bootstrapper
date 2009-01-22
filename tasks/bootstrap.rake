namespace :db do
  desc "Bootstraps the database for the given environment. BOOTSTRAP option lets you run a specific bootstrap task in the given environment."
  task :bootstrap => :environment do
    require File.join(RAILS_ROOT, 'db', 'bootstrap')
    Bootstrapper.run(ENV['BOOTSTRAP'] || RAILS_ENV)
  end

  namespace :bootstrap do
    desc "Resets the database and bootstraps it for the given environment. BOOTSTRAP option lets you run a specific bootstrap task in the given environment."
    task :reset => 'db:migrate:reset' do
      Rake::Task['db:bootstrap'].invoke
    end

    desc "Resets the rails environment"
    task :reset_environment do
      # Ripped directly out of railties/lib/console_app.rb in rails and
      # only changed slightly.
      puts "Reloading environment..."
      dispatcher = ActionController::Dispatcher.new($stdout)
      dispatcher.cleanup_application
      dispatcher.reload_application
    end
  end
end
