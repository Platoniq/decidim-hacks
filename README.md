# decidim-hacks

Free Open-Source participatory democracy, citizen participation and open government for cities and organizations

This is the open-source repository for decidim-hacks, based on [Decidim](https://github.com/decidim/decidim).

## Setting up the application

This instance is intended to allow anyone interested to experiment with Decidim in a easy way by using Docker.

**This instance is for educational purposes and should not be used for production sites.**

### Requirements: 

1. Install **Docker** and **Docker-compose**, find the official guides to install them here:
    - [Windows 10](https://runnable.com/docker/install-docker-on-windows-10) and the [official](https://docs.docker.com/docker-for-windows/install/).

      We've also created a step-by-step guide to [install Docker on Windows Home Editions](docs/install-docker-on-windows-10-home.md). **Highly recommended if you are not familiar with docker.**

    - [Mac OS X](https://runnable.com/docker/install-docker-on-macos) and the [official](https://docs.docker.com/docker-for-mac/install/).

      If in doubt, check our step-by-step guide to [install Docker on Mac OS X](docs/install-docker-on-macos.md).

    - [Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/) (Ubuntu, find other OS in the same place). Also remember to install [docker-compose](https://docs.docker.com/compose/install/).

2. Clone this repository or [download and unpack it](https://github.com/Platoniq/decidim-hacks/archive/master.zip) in some place.

```
git clone https://github.com/Platoniq/decidim-hacks.git
```

### Running the application

Just open a terminal where you have cloned or downloaded this repository and execute:

```
docker-compose up
```

Depending on your case you might have to add `sudo` before the command. Is going to be a while the first time...

Point your browser to: http://localhost:3000

> **NOTE:** If you are using Windows and Docker Toolbox, `localhost` cannot be used to access a docker container. You can use the following command (while docker is up) to change it:
> ```
> docker-compose exec app bin/rails db:seed:hostname-windows-toolbox
> ```
> After that, you can use the address http://192.168.99.100:3000 instead.
> 
> Please read the complete guide to [install Docker on Windows Home Editions](docs/install-docker-on-windows-10-home.md) for further detail.

## Hack something

You can open the file `app/views/layouts/decidim/_head_extra.html.erb` and change something in it, then refresh your browser.

## Contributing
 
You are wellcome to contribute by posting issues or PR.
 
Happy hacking!

