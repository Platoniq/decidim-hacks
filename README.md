# decidim-hacks

Free Open-Source participatory democracy, citizen participation and open government for cities and organizations

This is the open-source repository for decidim-hacks, based on [Decidim](https://github.com/decidim/decidim).

## Setting up the application

This instance is intended to allow anyone interested to experiment with Decidim in a easy way by using Docker.

### Requirements: 

2. Install **Docker** and **Docker-compose**, find the official guides to install them here:
    - [Windows 10](https://runnable.com/docker/install-docker-on-windows-10) and the [official](https://docs.docker.com/docker-for-windows/install/)
    - [Mac OS X](https://docs.docker.com/docker-for-mac/install/) and the [official](https://runnable.com/docker/install-docker-on-macos)
    - [Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/) (Ubuntu, find other OS in the same place)

2. Clone this repository or [download and unpack it](https://github.com/Platoniq/decidim-hacks/archive/master.zip) in some place.

```
git clone https://github.com/Platoniq/decidim-hacks.git
```

### Init

Just open a terminal where you have cloned or downloaded this repository and execute:

```
docker-compose up
```

Is going to be a while the first time...

Point your browser to: http://localhost:3000

## Hack something

You can open the file `app/views/layouts/decidim/_head_extra.html.erb` and change something in it, then refresh your browser.

Happy hacking!

