FROM centos:centos7

MAINTAINER clairvy@gmail.com

USER root
ENV HOME /root

# make user admin
RUN useradd admin

# install git
RUN yum install -y git
# install tools requred ruby install
RUN yum install -y gcc make openssl-devel tar
# make directory to serverspec
RUN mkdir /serverspec && chown admin.admin /serverspec

# install rbenv
USER admin
ENV HOME /home/admin
RUN git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile
RUN git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build

# install ruby
RUN source $HOME/.bash_profile && rbenv install 2.1.2 && rbenv global 2.1.2

# install bundle
RUN source $HOME/.bash_profile && gem install bundle

# install serverspec
RUN source $HOME/.bash_profile && cd /serverspec && printf "source 'https://rubygems.org'\ngem 'serverspec'" > Gemfile && bundle

CMD source $HOME/.bash_profile && rbenv
