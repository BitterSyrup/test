FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html
COPY DockerFileEx.jpg /usr/share/nginx/html/DockerFileEx.jpg

EXPOSE 80

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-18.09.7-ce.tgz \
  && tar xzvf docker-18.09.7-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-18.09.7-ce.tgz
