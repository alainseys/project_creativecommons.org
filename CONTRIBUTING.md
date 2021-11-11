# Contributing

There are many ways to contribute to this project, such as testing, design, and development.


## Development

This section provides information for people who are interested in contributing code.

### Development dependencies

Make sure you have installed [Docker](https://docs.docker.com/get-docker/) and `docker-compose` for your operating system prior to following these instructions. Alternatively, you can use the browser-based development environment described below.

### Browser-based development environment

You may use a browser-based development environment instead of installing Docker and Docker Compose locally. Just click the "Develop with Gitpod" button below to launch a pre-configured development environment. Once the environment opens in your browser, continue with the following sections (skipping sections handled automatically by Gitpod as noted).

**WARNING**: remember to delete your Gitpod workspace when you are done with development each day. Otherwise, you may quickly exceed your open-source Gitpod credits. Be sure to push all desired changes in your Gitpod workspace to GitHub prior to deletion.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/creativecommons/project_creativecommons.org)

### Initialize Git submodules

Note: this step is handled automatically in the browser-based development environment.

This project consists of several components, such as WordPress themes, that are developed in their own Git repositories. If you have already cloned this project's code, make sure the Git sub-modules are activated by running the following command.

```sh
git submodule update --init
```

Alternatively, you can initialize the submodules when you clone the repository with the following command.

```sh
git clone --recursive
```

### Updating Git submodules

The Git submodule projects are under active development. When the submodule code changes, we can update our project to track the latest changes using the following command.

```sh
git submodule update --remote --merge
```

## Environment variables

There are several optional environment variables used in the `docker-compose.yml` file. If you need, you can  copy the `.env.example` to `.env` and override the variables. Otherwise, the defaults should work fine.

### Changing database

The optional `.env` file may contain a variable called `DATABASE`. The value of `DATABASE` will determine which database is used for development (`mysql` or `mariadb`). By default, we use `mariadb` but you can change this to `mysql` if desired.

If you change the value of the `DATABASE` variable at any time during development, you will need to remove the old database volume in order and rebuild the images to prevent errors.

1. list all Docker volumes to find the relevant volume
    - `docker volume ls`
2. remove the volume
    - `docker volume rm <volume-id>`
3. rebuild the docker image
    - `docker-compose up --build -d`

### Run the development server

Once you have installed the above development dependencies, you can run the following commands from within this project directory.

#### Start the server

Note: this step is handled automatically in the browser-based development environment.

```sh
docker-compose up
```

#### Stop the server

```sh
docker-compose down
```

### Access WordPress

After starting the server, you should be able to access WordPress at http://127.0.0.1:8080

### Install WordPres (first-time)

If you are starting the WordPress service for the first time, you will see the WordPress installation wizard. Complete the installation process and make note of your username and password so that you can log in (below).


### Log in to WordPress

With the development server running, log in to the local WordPress with the login credentials you created during the WordPress installation.

Note: you will need to visit http://127.0.0.1:8080/wp-login.php


### Access the WordPress admin area

Once you are logged in with your admin user (above), you can access the WordPress admin area:

- http://127.0.0.1:8080/wp-admin/


### Activate CC theme and plugins

From the WordPress admin area, you can activate the Creative Commons WordPress theme and plugins.

### Developing Gutenberg blocks

This project contains the `wp-plugin-cc-gutenberg-blocks` project as a Git submodule. Do the following, if you would like to develop CC Gutenberg blocks in the context of `project_creativecommons.org`.

1. make sure you have completed all of the above steps so the Docker Compose project is running
2. open a new teminal
3. change directory `cd` into `wp-plugin-cc-gutenberg-blocks`
4. run `npm install` to install dependencies
5. run `npm start` to start the Gutenberg block development project

From there, you can make changes to files in `wp-plugin-cc-gutenberg-blocks/src/` that will automatically build. Commits made to that submodule can be pushed to branches in the upstream project as well.
