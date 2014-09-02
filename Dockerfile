FROM danieldreier/wheezy-puppet-agent
MAINTAINER Daniel Dreier <ddreier@thinkplango.com>

EXPOSE 8140
RUN mkdir /opt/dockermaster
WORKDIR /opt/dockermaster

RUN apt-get update; apt-get install -y ruby-dev make g++ cron
RUN mkdir /opt/dockermaster/environments ; mkdir /opt/dockermaster/basemodules
ADD puppet.conf /etc/puppet/puppet.conf
ADD hiera.yaml /etc/puppet/hiera.yaml
ADD hiera.yaml /etc/hiera.yaml

CMD puppet master --no-daemonize

# run me with:
# 1) build the r10k-builder container
# 2) build and run the ssl datafile container to get the ssl data volume
# 3) build and run the site-repo/Dockerfile container to get the site module volume
# 4) docker run -t -i  -p 8140:8140 --rm --volumes-from=puppetmaster-ssl-data --volumes-from=site-module -h puppetmaster.example.com danieldreier/docker-puppetmaster
