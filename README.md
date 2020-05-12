# Ontop

## How to use this image
The image `streamreasoning/ontop` is for fast setting up an [Ontop](https://ontop-vkg.org/) SPARQL endpoint. It includes connectors for `h2` and `mysql` databases.

## Example
Assume that the following files are in the working directory:

```bash
.
├── input
│   ├── cooking.properties
│   ├── cooking.obda
│   └── cooking-mapping.ttl
└── sql
    └── init.sql
```

The files `cooking.properties`, `cooking.obda` and `cooking-mapping.ttl` can be generated using the [Ontop plugin](https://protegewiki.stanford.edu/wiki/Ontop) in [Protégé](https://protege.stanford.edu/).

You can start an Ontop SPARQL endpoint by using the `streamreasoning/ontop` image.

```yml
version: '3.5'
services:
  mysql:
    image: mysql:5.7
    container_name: mysql
    ports:
      - "3306:3306"
      - "33060:33060"
    volumes:
      - $PWD/sql/:/docker-entrypoint-initdb.d
    environment:
      - MYSQL_ROOT_PASSWORD=password
      - MYSQL_DATABASE=db
      - MYSQL_USER=user
      - MYSQL_PASSWORD=pass
  ontop:
    image: streamreasoning/ontop:3.0.1
    container_name: ontop
    ports:
      - "8080:8080"
    volumes:
      - $PWD/input:/ontop/input
    environment:
      - TTL_PATH=cooking-mapping.ttl
      - ODBA_PATH=cooking.obda
      - PROPERTIES_PATH=cooking.properties
```

Then, you can access the SPARQL endpoint at [http://localhost:8080](http://localhost:8080).