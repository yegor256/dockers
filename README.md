# A Few Convenient Docker Images

Just a collection of convenient Docker images.

* [`yegor256/ruby`](https://hub.docker.com/repository/docker/yegor256/ruby)
* [`yegor256/java`](https://hub.docker.com/repository/docker/yegor256/java)
* [`yegor256/python`](https://hub.docker.com/repository/docker/yegor256/python)
* [`yegor256/latex`](https://hub.docker.com/repository/docker/yegor256/latex)

All of them are used by [Rultor] in all our repositories.

In order to build and push them, use Make (provided, you are logged into
the Docker Hub already):

```bash
make
```

Just to test, use `make test`.

[Rultor]: https://www.rultor.com
