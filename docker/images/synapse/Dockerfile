FROM ubuntu:12.04
MAINTAINER talkingquickly.co.uk <ben@talkingquickly.co.uk>

ENV DEBIAN_FRONTEND noninteractive

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q python-software-properties
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -y update

# INSTALL
RUN apt-get install -y -q build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config libmysqlclient-dev libpq-dev make wget unzip git vim nano nodejs mysql-client mysql-server gawk libgdbm-dev libffi-dev

RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
    cd /tmp/ruby-build && \
    ./install.sh && \
    cd / && \
    rm -rf /tmp/ruby-build

# Install ruby
RUN ruby-build -v 2.0.0-p481 /usr/local
 
# Install base gems
RUN gem install bundler rubygems-bundler --no-rdoc --no-ri
 
# Regenerate binstubs
RUN gem regenerate_binstubs

RUN gem install "synapse"

RUN \
  apt-get install -y haproxy && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy

RUN apt-get install -y -q supervisor openssh-server

RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD has_proxy_config /etc/haproxy/haproxy.cfg

RUN chown haproxy:haproxy /etc/haproxy/haproxy.cfg

RUN mkdir /var/lib/haproxy

ADD ./config.json /synapse-config.json

EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
