set :to,          ENV['to'] || 'development'
set :application, "carehouse"
set :deploy_to,   "/var/app/#{application}"
set :repository,  "git@github.com:jaknowlden/carehouse.git"
set :cold,        false # not doing cold deploys by default
set :revision,    ENV['REV'] || 'origin/master'
set :timestamp,   Time.now.strftime("%Y%m%d%H%M%S")

require "config/deploy/#{to}"

#
# Routine tasks

namespace :deploy do
  remote_task :symlink_configs, :roles => :app do
    run "ln -nfs #{shared_path}/config/config.yml #{latest_release}/config/config.yml"
  end
end

remote_task 'vlad:update_symlinks', :roles => :app do
  Rake::Task['deploy:symlink_configs'].invoke
end

desc "Deploys the latest set of code (use this most often)"
task 'vlad:deploy' => ['vlad:update', 'vlad:cleanup']

#
# One time tasks

remote_task 'vlad:setup_app', :roles => :app do
  run "mkdir #{shared_path}/config"
  run "touch #{shared_path}/config/config.yml"
end

remote_task "vlad:restart", :roles => :app do
  run "touch #{current_path}/tmp/restart.txt"
end
