## Prerequisites
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

Make sure you have installed Docker and `docker-compose` for your operating system prior to following these instructions.

## Docker compose

The Docker compose file will start a few required or related services:

- a database server (MySQL or MariaDB)
- a WordPress server
- WordPress CLI - for managing the WordPress instance
- phpMyAdmin - for managing the database


## Environment variables

There are several environment variables required to run the `docker-compose` command. Copy the `.env.example` to `.env` and override the variables if needed. The defaults should work fine.

## Changing database

The `.env` file should contain a variable called `DATABASE` that is used to choose which database to use for development (mysql or mariadb).

If you change the value of the `DATABASE` variable at any time during development, you will need to remove the old database volume in order and rebuild the images to prevent errors. 

1. list all Docker volumes to find the relevant volume
    - `docker volume ls`
2. remove the volume
    - `docker volume rm <volume-id>`
3. rebuild the docker image
    - `docker-compose up --build -d`

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://www.epacking.be"><img src="https://avatars.githubusercontent.com/u/19891785?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Alain Seys</b></sub></a><br /><a href="https://github.com/creativecommons/project_creativecommons.org/commits?author=alainseys" title="Code">💻</a> <a href="#infra-alainseys" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/creativecommons/project_creativecommons.org/commits?author=alainseys" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!