# ampache-docker

This is a out-of-the-box Ampache image, built on top of Alpine Linux, MariaDB and Nginx.

## Usage
```
docker run --name=ampache -d -v /path/to/your/music:/media:ro -p 80:80 ampache/ampache
```

## First run

Go to http://<AMPACHE_IP> and follow instuctions.

MySQL user is : ampache

MySQL password is : ampache

When installation id done, go to admin page.
Then create a catalog for your music mounted in /media.

## Customize image

You can build a custom image according to your needs.
All ENV vars from Dockerfile can be overriden at build.

Example if you want to increase PHP memory :

```
cd <repo>
docker build -t ampache:mytag --build-arg PHP_MEMORY_LIMIT=1024M .
```

Then run it :
```
docker run --name=ampache -d -v /path/to/your/music:/media:ro -p 80:80 ampache:mytag
```



## Supported architectures

amd64
arm64v8



