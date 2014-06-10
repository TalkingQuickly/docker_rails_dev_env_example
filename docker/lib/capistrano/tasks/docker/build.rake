namespace :docker do
  desc "Builds docker images on vagrant and pushes"
  task :build do
    get_images.each do |conf|
      if conf[:dockerfile]
        sh "vagrant ssh -c 'docker build -t #{conf[:image]} #{dockerfile_path(conf)}'"
      end
    end

  end

  def get_images
    images = []
    on roles(:docker) do |role|
      conf = role.fetch(:docker)
      images << {
        image: conf[:image],
        dockerfile: conf[:dockerfile]
      }
    end

    images.uniq
  end

  def dockerfile_path(conf)
    "/app#{conf[:dockerfile]}"
  end
end
