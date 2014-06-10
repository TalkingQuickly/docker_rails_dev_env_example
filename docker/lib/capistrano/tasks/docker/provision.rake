namespace :docker do
  desc "Sets up all containers"
  task :provision do
    on roles(:docker) do |role|
      conf = role.fetch(:docker)
      execute docker_stop_cmd(conf)
      execute docker_rm_cmd(conf)
      execute docker_run_cmd(conf)
    end
  end

  def generate_flags(values, flag)
    out = ""
    values.each do |val|
      out += " #{flag} #{val} " 
    end
    out
  end

end
