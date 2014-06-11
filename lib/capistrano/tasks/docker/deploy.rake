namespace :docker do
  desc "builds docker containers on Vagrant VM"
  task :deploy do
    on roles(:app) do |role|
      puts role
    end
  end
end
