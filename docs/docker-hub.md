# Building Docker

This application is available as a Docker image in:
https://cloud.docker.com/u/platoniq/repository/docker/platoniq/decidim-hacks

To build a new image we use the `docker/Dockerfile` file:

```
sudo docker build . -t platoniq/decidim-hacks:VERSION -f docker/Dockerfile
```

To upload it to the Docker hub (permissions needed):

```
sudo docker login
sudo docker push platoniq/decidim-hacks:VERSION
sudo docker tag platoniq/decidim-hacks:VERSION platoniq/decidim-hacks:latest
sudo docker push platoniq/decidim-hacks:latest
```
