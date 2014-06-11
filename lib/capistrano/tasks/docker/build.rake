namespace :docker do
  desc "builds docker containers on Vagrant VM"
  task :build do
    run_locally do
      execute ""
    end
  end
end
