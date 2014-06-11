# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'docker_postgres_example'
set :repo_url, 'git@github.com:TalkingQuickly/docker_rails_dev_env_example.git'

set :docker_namespace, 'talkingquickly'

set :pty, true

set :branch, "feature/capistrano-docker"

namespace :deploy do

  after :publishing, "docker:deploy"

end
