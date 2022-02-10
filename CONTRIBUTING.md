# Contributing

There are many ways to contribute to this project, such as testing, design, and development.

## Development

This section provides information for people who are interested in contributing code.

### Install Docker

Install Docker ([Install Docker Engine | Docker
Documentation][installdockerengine]) and Docker Compose ([Install Docker
Compose | Docker Documentation][installdockercompose]).

References:

- [Dockerfile reference | Docker Documentation][dockerfile]
- [Compose file version 3 reference | Docker Documentation][dockercompose3]

Alternatively, you can
use the browser-based development environment described below.

[installdockerengine]: https://docs.docker.com/engine/install/
[installdockercompose]: https://docs.docker.com/compose/install/
[dockerfile]: https://docs.docker.com/engine/reference/builder/
[dockercompose3]: https://docs.docker.com/compose/compose-file/compose-file-v3/

### Browser-based development environment

You may use a browser-based development environment instead of installing Docker and Docker Compose locally. Just click the "Develop with Gitpod" button below to launch a pre-configured development environment. Once the environment opens in your browser, continue with the following sections (skipping sections handled automatically by Gitpod as noted).

:warning: **WARNING**: remember to delete your Gitpod workspace when you are done with development each day. Otherwise, you may quickly exceed your open-source Gitpod credits. Be sure to push all desired changes in your Gitpod workspace to GitHub prior to deletion.

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

There are several optional environment variables used in the `docker-compose.yml` file. If you need, you can copy the `.env.example` to `.env` and override the variables. Otherwise, the defaults should work fine.

### Changing database

The optional `.env` file may contain a variable called `DATABASE`. The value of `DATABASE` will determine which database is used for development (`mysql` or `mariadb`). By default, we use `mariadb` but you can change this to `mysql` if desired.

If you change the value of the `DATABASE` variable at any time during development, you will need to remove the old database volume in order and rebuild the images to prevent errors.

1. list all Docker volumes to find the relevant volume
   - `docker volume ls`
2. remove the volume
   - `docker volume rm <volume-id>`
3. rebuild the docker image
   - `docker-compose up --build -d`

### CC Legal Tools development

If you are actively developing the CC Legal Tools, your experience may be
improved by replacing the submodule with a symlink (:warning: be careful not to
commit this change):

```sh
rm -rf cc-legal-tools-data; ln -s ../cc-legal-tools-data .
```

You can revert the change with:

```sh
rm cc-legal-tools-data; git restore cc-legal-tools-data; git submodule update --init
```

### Run the development server

Once you have installed the above development dependencies, you can run the following commands from within this project directory.

#### Start the server

Note: this step is handled automatically in the browser-based development environment.

```sh
docker-compose up
```

The command above will create a variety of docker services:

1. **wordpress** ([127.0.0.1:8000](http://127.0.0.1:8000/))
2. **database** (also available directly on port `3306`)
3. **phpmyadmin** ([127.0.0.1:8003](http://127.0.0.1:8003/))
4. **composer**

#### Stop the server

```sh
docker-compose down
```

### Install WordPres (first-time)

If you are starting the WordPress service for the first time, you will see the
WordPress installation wizard:

- [127.0.0.1:8000/wp-admin/install.php](http://127.0.0.1:8000/wp-admin/install.php)

Complete the installation process and make note of your username and password
so that you can log in (below).

### Log in to WordPress

With the development server running, log in to the local WordPress with the
login credentials you created during the WordPress installation:

- [127.0.0.1:8000/wp-login.php](http://127.0.0.1:8000/wp-login.php).

### Access the WordPress admin area

Once you are logged in with your admin user (above), you can access the
WordPress admin area:

- [127.0.0.1:8000/wp-admin/](http://127.0.0.1:8000/wp-admin/)

### Activate CC theme and plugins

From the WordPress admin area, you can activate the Creative Commons WordPress child theme from the [Theme Settings](http://127.0.0.1:8000/wp-admin/themes.php) and [Plugins](http://127.0.0.1:8000/wp-admin/plugins.php) pages respectively. Note, some plugins may be automatically enabled by our Docker compose service.

The child theme is called `creativecommons.org Child theme`.

### Import staging content

We have prepared some pre-existing content based on the desired page and URL structure for the new Creative Commons website, which is located in the `content-import` folder in the file `staging-content-import.xml`.

The WordPress documentation contains an article describing [how to import content](https://wordpress.org/support/article/tools-import-screen/).

Alternatively, use the WordPress CLI to import the content. See the WordPress CLI instructions below.

### Enable URL rewrites for clean API URLs

Visit the [Permalink Settings](http://127.0.0.1:8000/wp-admin/options-permalink.php) page to enable clean URLs, such as might be used by external sites and services.

Alternatively, see the WordPress CLI section below for an example of how to enable clean URLs via command line.

### Working with the WordPress CLI

The development environment contains a [WordPress CLI](https://wp-cli.org/) container that may prove useful for interacting with WordPress from the shell. Further details about specific WP CLI commands can be found in the [WP-CLI Handbook](https://make.wordpress.org/cli/handbook/).

Use the following to send commands to the `wordpress-cli` Docker container:

```sh
docker-compose run --rm wordpress-cli
```

#### Create an alias for the WordPress CLI container

Optionally, add the following alias to make it easier to interact with the WordPress CLI.

``` sh
alias wp="docker-compose run --rm wordpress-cli"`
```

Verify the alias:

```sh
wp --info
```

#### Import content

The following WordPress CLI command can be used to import content, such as the `staging-content-import.xml`

``` sh
wp import  content-import/staging-content-import.xml --authors=create
```

#### Enable clean URLs

The following command will set up clean URLs, such as may be needed by downstream sites or services.

``` sh
wp rewrite structure '/%postname%'
```

### Developing Gutenberg blocks

This project contains the `wp-plugin-cc-gutenberg-blocks` project as a Git submodule. Do the following, if you would like to develop CC Gutenberg blocks in the context of `project_creativecommons.org`.

1. make sure you have completed all of the above steps so the Docker Compose project is running
2. open a new teminal
3. change directory `cd` into `wp-plugin-cc-gutenberg-blocks`
4. run `npm install` to install dependencies
5. run `npm start` to start the Gutenberg block development project

From there, you can make changes to files in `wp-plugin-cc-gutenberg-blocks/src/` that will automatically build. Commits made to that submodule can be pushed to branches in the upstream project as well.
