set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

set :deploy_to, "/home/vagrant/apps/#{fetch(:full_app_name)}"

server 'webfrontend.docker.local',
  user: 'vagrant', 
  keys: %w(/Users/ben/.vagrant.d/insecure_private_key),
  roles: %w{web docker}, 
  docker: {
    image: 'talkingquickly/nginx-loadbalance',
    dockerfile: "/docker/images/nginx",
    name: 'webfrontend',
    links: ["rails1:app1"],
    mount_app: true,
    envs: ["HOSTNAME=captest.talkingquickly.co.uk","NODES=127.0.0.1:3001"],
    ports: ["80:80"]
    },
  port: 2222

server 'app1.docker.local',
  user: 'vagrant', 
  keys: %w(/Users/ben/.vagrant.d/insecure_private_key),
  roles: %w{app docker}, 
  docker: {
    image: 'talkingquickly/rails',
    dockerfile: "/",
    name: 'rails1',
    links: ["pg1:db"],
    mount_app: true,
    envs: ["RAILS_ENV=production"],
    ports: ["3001:3000"]
    },
  port: 2222

server 'pg1.docker.local',
  user: 'vagrant', 
  keys: %w(/Users/ben/.vagrant.d/insecure_private_key),
  roles: %w{db docker}, 
  docker: {
    image: 'talkingquickly/postgres',
    dockerfile: "/docker/images/postgres",
    name: 'pg1',
    links: [],
    envs: ["POSTGRESQL_USER=docker","POSTGRESQL_PASS=docker"],
    ports: []
    },
  port: 2222


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
