namespace :docker do
  desc "Pushes Docker images to docker.io index"
  task :push do
    get_images.each do |conf|
      if conf[:dockerfile]
        sh "vagrant ssh -c 'docker push #{conf[:image]}'"
        
      end
    end
  end
end
