# ampache-docker

This is a out-of-the-box Ampache image, built on top of Alpine Linux, MariaDB and Nginx.

## Usage
```
docker run --name=ampache -d -v /path/to/your/music:/media -p 80:80 mishka81/ampache-docker
```


## First run

Go to http://<AMPACHE_IP> and follow instuctions.

MySQL user and password is "ampache".

When installation is done, go to admin page, then create a catalog for your music volume, with path "/media".

## Customizations


### Volume access permissions

By default, container has read/write acces to music volume with user / group id 1000.

If not, you can specify your uid and gid like this :
```
docker run --name=ampache -d -v /path/to/your/music:/media -e "UID=<your_uid>" -e "GID=<your_gid" -p 80:80 mishka81/ampache-docker
```


You can override all ENV variables defined in DockerFile with 
```
-e "ENVVAR=VALUE"
```

For example, you can adjust memory used by PHP in container.

See DockerFile.

All ENV vars from Dockerfile can be overriden at build.

Example if you want to increase PHP memory :

```
cd <repo>
docker build -t ampache:mytag --build-arg PHP_MEMORY_LIMIT=1024M .
```

Then run it :
```
docker run --name=ampache -d -v /path/to/your/music:/media -p 80:80 ampache:mytag
```



## Supported architectures

amd64
arm64v8



