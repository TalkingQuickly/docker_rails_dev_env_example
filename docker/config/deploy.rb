# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'my_app_name'
set :repo_url, 'git@example.com:me/my_repo.git'

set :docker_namespace, 'talkingquickly'

set :pty, true

namespace :deploy 

  after :publishing, "docker:deploy"

end
