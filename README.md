# A Few Convenient Docker Images

[![make](https://github.com/yegor256/dockers/actions/workflows/make.yml/badge.svg)](https://github.com/yegor256/dockers/actions/workflows/make.yml)

Just a collection of convenient Docker images.

* [`yegor256/ruby`](https://hub.docker.com/repository/docker/yegor256/ruby)
* [`yegor256/java`](https://hub.docker.com/repository/docker/yegor256/java)
* [`yegor256/python`](https://hub.docker.com/repository/docker/yegor256/python)
* [`yegor256/latex`](https://hub.docker.com/repository/docker/yegor256/latex)

All of them are used by [Rultor] in all our repositories.

In order to build them all, use Make:

```bash
make
```

When they are all ready, push them to [Docker Hub]
(provided, you are [logged] into it aleady).

[Rultor]: https://www.rultor.com
[Docker Hub]: https://hub.docker.com/
[logged]: https://docs.docker.com/reference/cli/docker/login/
