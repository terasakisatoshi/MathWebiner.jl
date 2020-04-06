# MathWebiner.jl
My Math/Julia homepage based on [Franklin.jl](https://github.com/tlienart/Franklin.jl)

![Build and Deploy](https://github.com/terasakisatoshi/MathWebiner.jl/workflows/Build%20and%20Deploy/badge.svg?branch=master)

[This Repository](https://github.com/terasakisatoshi/MathWebiner.jl) builds [my website](https://terasakisatoshi.github.io/MathWebiner.jl/) using [Franklin.jl](https://github.com/tlienart/Franklin.jl)

# How to build

- Install Docker, DockerCompose
- Run:

```console
$ make
$ docker-compose up web
```

If you like to reset state i.e. remove `__site`, use `webscratch`

```console
$ make
$ docker-compose up webscratch
```