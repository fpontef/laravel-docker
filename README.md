# Laravel Docker

> Just copy or create a project into src folder
> Based on laracasts docker tutorial plus modifications for my needs

- ngnix: file server
- mariaDB: database
- php: language with extensions
- composer: php util and laravel requirement
- artisan: laravel util
- node: npm util

## Some useful information

- Ports
nginx - 8080 (external)  / 80 (internal/between containers)
mysql/mariadb - 3308 / 3306 (internal/between containers)

- The configuration runs on UID/GID 1000, using laravel and node to avoid root
- This ensures that a linux with sudo docker won't have permission issues
- Tested with ArchLinux

- Folder
`./src`: Store the laravel project
`./nginx`: Store the nginx configuration and certificates
`./mysql`: Store the mysql or mariadb data

- Docker images/builds
nginx using the `nginx.dockerfile` or `nginx.prod.dockerfile`
composer using the `composer.dockerfile`
php and artisan using the `php.dockerfile` or `php.prod.dockerfile`
mysql using the `mariadb:10.5` docker hub image
npm usind the `npm:current-alpine` docker hub image

## Instalation

### Development

- Clone this repo;
- Start nginx (will start mysql and php as dependencies)
`docker-compose up -d --build nginx`

- Will be accessible at `http://localhost:8080/`

- `src` folder will be where to install the laravel project or php project
- For Simple PHP just create a public folder and use index.html or index.php
  - Create a public folder
   `mkdir src/public`

  - Create a simple php
   `echo "<?php echo 'Its alive!';" > src/public/index.php`

  - And check `http://localhost:8080/` for changes.

- For Laravel Project follow:
  - To create a brand new laravel project (after you ran docker-compose up nginx step)
    `docker-compose run --rm composer create-project laravel/laravel .`
    Note: there's a period "." at the end of the command, don't worry because composer service have the work path to handle what is the current folder we want.

  - configure .env file inside src folder

  - .env file from laravel example for database

    ```console
    DB_CONNECTION=mysql
    DB_HOST=mysql
    DB_PORT=3306
    DB_DATABASE=laravel
    DB_USERNAME=laravel
    DB_PASSWORD=secret
    ```

### Other Available commands

- Inside folder, check for running containers:
`docker compose ps`

- Stop containers:
`docker-compose down`

- composer usage
`docker-compose run --rm composer update`

- npm usage
`docker-compose run --rm npm run dev`

- artisan usage
`docker-compose run --rm artisan migrate`

### Production (still testing)

- Generate certs and key
`mkcert myawesomedomain.com`

- Copy cert and key files to `nginx` folder

- Edit `nginx.prod.dockerfile` and `nginx/default.prod.conf` to inform the files and server_name.

- Build the production version
`docker-compose -f docker-compose.yml -f docker-compose.prod.yml up --build ngnix`
