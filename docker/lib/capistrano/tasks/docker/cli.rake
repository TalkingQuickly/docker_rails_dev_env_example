namespace :docker do
  def docker_rm_cmd(conf)
    "docker rm #{conf[:name]}"
  end

  def docker_pull_cmd(conf)
    "docker pull #{conf[:image]}"
  end

  def docker_run_cmd(conf)
    cmd = "docker run -d --name #{conf[:name]} "
    cmd += generate_flags(conf[:links], '--link')
    cmd += generate_flags(conf[:ports], '-p')
    cmd += generate_flags(conf[:envs], '-e')
    cmd += "#{conf[:image]}:latest"
  end

  def docker_stop_cmd(conf)
    "docker stop #{conf[:name]}"
  end
end