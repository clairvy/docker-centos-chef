FROM centos:centos7

MAINTAINER clairvy@gmail.com

USER root
ENV HOME /root

# install git
RUN yum install -y git

# install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
ADD home/.bash_profile $HOME/.bash_profile
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile
RUN git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build

# install ruby
# install tools requred ruby install
RUN yum install -y gcc make openssl-devel tar
RUN source $HOME/.bash_profile && rbenv install 2.1.2 && rbenv global 2.1.2

# install bundle
RUN source $HOME/.bash_profile && gem install bundle

# install sudo
RUN yum install -y sudo
# install docker
RUN yum install -y docker

# install serverspec
# make directory to serverspec
#RUN mkdir /serverspec && chown admin.admin /serverspec
RUN mkdir /serverspec
ADD home/Gemfile /serverspec/Gemfile
RUN source $HOME/.bash_profile && cd /serverspec && bundle

CMD source $HOME/.bash_profile && rbenv
