## Prerequisites
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

## Development

### Development dependencies
Make sure you have installed [node/npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm), [Docker]
(https://docs.docker.com/get-docker/), and `docker-compose` for your operating system prior to following these instructions.

We are using the [`wordpress/env` project](https://developer.wordpress.org/block-editor/reference-guides/packages/packages-env/) to simplify our developer experience. Please follow the `wordpress/env` installation instructions.


### Initialize Git submodules

This project consists of several components, such as WordPress themes, that are developed in their own Git repositories. If you have already cloned this project's code, make sure the Git sub-modules are activated by running the following command.

```sh
git submodule update --init
```

Alternatively, you can initialize the submodules when you clone the repository with the following command.

```sh
git clone --recursive
```

### Run the development server

Once you have installed the above development dependencies, you can run the following commands from within this project directory.

#### Start the server

```sh
wp-env start
```

**Note: if you get an [error related to Xdebug when starting the server](https://github.com/WordPress/gutenberg/issues/34320), make sure to prune old Docker images with

```
docker image prune -a
```

#### Stop the server

```sh
wp-env stop
```

### Log in to WordPress

With the development server running, log in to the local WordPress with the default login credentials.

- username: admin
- password: password

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://www.epacking.be"><img src="https://avatars.githubusercontent.com/u/19891785?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Alain Seys</b></sub></a><br /><a href="https://github.com/creativecommons/project_creativecommons.org/commits?author=alainseys" title="Code">💻</a> <a href="#infra-alainseys" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/creativecommons/project_creativecommons.org/commits?author=alainseys" title="Documentation">📖</a></td>
    <td align="center"><a href="https://zehta.me/"><img src="https://avatars.githubusercontent.com/u/691322?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Timid Robot Zehta</b></sub></a><br /><a href="https://github.com/creativecommons/project_creativecommons.org/pulls?q=is%3Apr+reviewed-by%3ATimidRobot" title="Reviewed Pull Requests">👀</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!