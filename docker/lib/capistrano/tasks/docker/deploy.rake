namespace :docker do
  desc "Deploys docker images to each host"
  task :deploy do
    on roles(:app) do |role|
      conf = role.fetch(:docker)

      execute docker_stop_cmd(conf)
      execute docker_rm_cmd(conf)
      execute docker_pull_cmd(conf)
      execute docker_run_cmd(conf)
    end
  end
end
