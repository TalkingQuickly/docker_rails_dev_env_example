namespace :docker do
  task :console do
    # @todo this won't work, you can't get
    # input like this on cap 3
    on primary(:app) do |role|
      conf = role.fetch(:docker)
      execute rails_cmd("rails console", conf)
    end
  end

  namespace :db do 
    task :migrate do
      on primary(:app) do |role|
        conf = role.fetch(:docker)
        execute rails_cmd("rake db:migrate", conf)
      end
    end

    task :create do
      on primary(:app) do |role|
        conf = role.fetch(:docker)
        execute rails_cmd("rake db:create", conf)
      end
    end
  end

  def rails_cmd(cmd, conf)
    "#{docker_run_interactive_cmd(conf)} bash -c 'cd /app && bundle && bundle exec #{cmd}'"
  end

  def cmd(cmd, conf)
    "#{docker_run_interactive_cmd(conf)} bash -c '#{cmd}'"
  end
end