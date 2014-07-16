FROM centos:centos7

MAINTAINER clairvy@gmail.com

USER root
ENV HOME /root

# install git
RUN yum install -y git

# install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile
RUN git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build

# install ruby
RUN yum install -y gcc make openssl-devel tar
RUN source $HOME/.bash_profile && rbenv install 2.1.2 && rbenv global 2.1.2

# install bundle
RUN source $HOME/.bash_profile && gem install bundle

# setup
ADD chef-repo /chef-repo

ENTRYPOINT ["/chef-repo/init"]
CMD ["run"]
