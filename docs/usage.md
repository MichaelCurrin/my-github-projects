# Usage
> Run locally

## Serve

Start the development server.

```sh
$ make serve
```

Open in the browser:

- http://localhost:4000/

## Debug

The Jekyll errors are not verbose, but this running with `--trace` command here. Note this will only build and not actually start the server.

```sh
$ make build-dev
```

If you want to disable fetching of GraphQL data, use this as a prefix before a command:

```sh
$ DISABLE_GQL=1 command
```
