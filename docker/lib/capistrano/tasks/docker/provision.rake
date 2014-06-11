namespace :docker do
  desc "Sets up all containers"
  task :provision do
    on roles(:db) do |role|
      conf = role.fetch(:docker)
      execute docker_stop_cmd(conf) rescue nil
      execute docker_rm_cmd(conf) rescue nil
      execute docker_run_cmd(conf)
    end

    on roles(:app) do |role|
      conf = role.fetch(:docker)
      execute docker_stop_cmd(conf) rescue nil
      execute docker_rm_cmd(conf) rescue nil
      execute docker_run_cmd(conf)
    end
  end
end

namespace :docker do
  desc "Convenience task for showing info"
  task :debug do
    on roles(:docker) do |role|
      conf = role.fetch(:docker)
      puts conf
    end
  end
end

