FROM mdsol/ruby26
MAINTAINER Piao <kpaku@mdsol.com>
LABEL com.mdsol.12f-buildType production

ARG DEBIAN_FRONTEND=noninteractive

# the yarn and nodejs repos use https, which requires apt-transport-https to be installed
# additionally, install tzdata to prevent any "/usr/bin/tzselect: time zone files are not set up correctly" error
RUN apt-get -q2 update && apt-get -q2 install apt-utils apt-transport-https tzdata

# add the NodeJS 10 and Yarn repos
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

# install NodeJS 10, Yarn and the headers for PostgreSQL
RUN apt-get -q2 install nodejs yarn libpq-dev

# cleanup now we're done installing stuff
RUN apt-get -q2 clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# app specific, unconfigurable
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV LOG_TO_FILE false
ENV LOG_TO_STDOUT true
ENV APP_HOME /home/app/web
ENV PIDS_DIR $APP_HOME/pids

WORKDIR $APP_HOME

# app codebase
ADD . $APP_HOME
# create the "pids" dir for puma
RUN mkdir -p $PIDS_DIR
RUN chown -R app:app $APP_HOME

# update rubygems in case the base image is providing an outdated version
RUN gem update --system -N > /dev/null && echo "using rubygems version `gem --version`"

# update bundler to match the version saved in the Gemfile.lock
# --force to prevent errors such as '"bundle" from bundler conflicts with /usr/local/bin/bundle'
RUN gem install bundler --force -N -v=`tail -n 1 Gemfile.lock | xargs` && bundle --version

# switching to app user
USER app

# bundle rubygems
RUN docker-ssh-exec bundle install --jobs=4 --deployment --without development test

# clear the entrypoint set by the base image
ENTRYPOINT []

# default to running the server even though this will be overridden by the command(s) in app_description
CMD ["bundle", "exec", "rails", "server"]
EXPOSE 3000
