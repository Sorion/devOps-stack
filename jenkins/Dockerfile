FROM jenkins/jenkins:latest

# if we want to install via apt
USER root
RUN apt-get update
RUN apt-get install -y curl wget xdg-utils
RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable && \
  rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs
# drop back to the regular jenkins user - good practice
USER jenkins
