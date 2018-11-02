# ampache-docker

This is a out-of-the-box Ampache image, built on top of Alpine Linux, MariaDB and Nginx.

## Usage

```
docker run --name=ampache -d -p <local_port>:80 -v /path/to/your/music:/media mishka81/ampache-docker
```

### Running on a different port

Example on port 8080 :

```
docker run --name=ampache -d -p 8080:8080 -e "NGINX_PORT=8080" -v /path/to/your/music:/media mishka81/ampache-docker
```

### Specify access to media volume

By default, container has read/write acces to music volume with user / group id 1000.

If your uid and gid are different, you can specify them like this :
```
docker run --name=ampache -d -v /path/to/your/music:/media -e "UID=<your_uid>" -e "GID=<your_gid" -p 80:80 mishka81/ampache-docker
```

### Customize PHP

You can also override all PHP ENV variables declared in DockerFile with option "-e".

Example to increase PHP memory :

```
docker run --name=ampache -d -v /path/to/your/music:/media -e "PHP_MEMORY_LIMIT=1024M" -p 80:80 mishka81/ampache-docker
```

However, default values should be OK in most situations.

## First run

Go to http://<AMPACHE_IP>:<AMPACHE_PORT> and follow instuctions.

MySQL user and password is "ampache".

When installation is done, go to admin page, then create a catalog for your music volume, with path "/media".

## Supported architectures

TODO : rasperry pi.




