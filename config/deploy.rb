
set :application, "html5"
set :location, "mknln.com"
set :use_sudo, false
set :port, 2222
set :user, "mpnolan"

set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :copy
set :copy_dir, "C:\\users\\mpn\\html5"
set :copy_remote_dir, "/home/mpnolan/public_html/html5"

ssh_options[:forward_agent] = true
ssh_options[:keys] = %w(C:/users/mpn/.ssh/id_rsa_mknln)

role :app, location
role :web, location
role :db, location

set :repository, ".\\root"
set :scm, :none

# Custom tasks for our hosting environment.
namespace :remote do

  desc <<-DESC
    Create directory required by copy_remote_dir.
  DESC
  task :create_copy_remote_dir, :roles => :app do
    print "    creating #{copy_remote_dir}.\n"
    run "mkdir -p #{copy_remote_dir}"
  end

end

# Override default tasks which are not relevant to a non-rails app.
namespace :deploy do
  task :migrate do
    puts "    not doing migrate because not a Rails application."
  end
  task :finalize_update do
    puts "    not doing finalize_update because not a Rails application."
  end
  task :start do
    puts "    not doing start because not a Rails application."
  end
  task :stop do 
    puts "    not doing stop because not a Rails application."
  end
  task :restart do
    puts "    not doing restart because not a Rails application."
  end
end

# Callbacks.
before 'deploy:setup', 'remote:create_copy_remote_dir'
