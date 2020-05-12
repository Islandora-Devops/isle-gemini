# isle-gemini

# ISLE 8 - Gemini image

Designed to used with:

* The Drupal 8 site
* The `isle-fcrepo` container
* The `isle-mariadb` container

Based on:

* [isle-crayfish-base](https://github.com/Islandora-Devops/isle-crayfish-base)

Contains and includes:

* [Composer](https://getcomposer.org/)
* [Gemini](https://github.com/Islandora/Crayfish/tree/dev/Gemini)

### Running

## Running

To run the container, you'll need to bind mount two things:

* A public key from the key pair used to sign and verify JWT tokens at `/opt/keys/public.key`
* A `php.ini` file with output buffering enabled at `/usr/local/etc/php/php.ini`

You'll also want to set some environment variables, which affect configuration of the microservice

* GEMINI_JWT_ADMIN_TOKEN - An easy to remember token to replace an actual JWT when testing (usually "islandora")
* GEMINI_LOG_LEVEL - Logging level for the Homarus microservice (DEBUG, INFO, WARN, ERROR, etc...)
* GEMINI_DB_DRIVER - Database driver (mariadb, mysql, pgsql)
* GEMINI_DB_HOST - Database host address
* GEMINI_DB_PORT - Database port
* GEMINI_DB_NAME - Gemini database name
* GEMINI_DB_USER - Gemini database user
* GEMINI_DB_PASSWORD - Gemini database password
* DB_ROOT_PASSOWRD - Root password (needed to build initially create Gemini database)

```
docker run -d -p 8000:8000 \
   -e HOMARUS_JWT_ADMIN_TOKEN=islandora \
   -e HOMARUS_LOG_LEVEL=DEBUG \
   -v /path/to/public.key:/opt/keys/public.key \
   -v /path/to/php.ini:/usr/local/etc/php/php.ini \
   isle-gemini`
```

### Testing

To test Gemini, you can issue curl commands against it to verify its endpoints are working.

For example, assuming that `GEMINI_JWT_ADMIN_TOKEN=islandora`, to create a pair in Gemini:

```
curl -i -H "Authorization: Bearer islandora" -X PUT -H "Content-Type: application/json" \
    -d '{"drupal" : "http://idcp:localhost:8000/node/1", "fedora" : "http://idcp.localhost:8080/fcrepo/rest/ab/70/12/7a/ab70127a-8579-4c17-af07-b3b1eceebb17"}' \
    http://idcp.localhost:8000/gemini/ab70127a-8579-4c17-af07-b3b1eceebb17
```

which should return

```
HTTP/1.1 201 Created
Date: Tue, 12 May 2020 02:27:56 GMT
Server: Apache/2.4.38 (Debian)
X-Powered-By: PHP/7.4.3
Cache-Control: no-cache, private
Location: http://idcp:localhost:8000/gemini/ab70127a-8579-4c17-af07-b3b1eceebb17
Content-Length: 0
Content-Type: text/html; charset=UTF-8
```

And now to fetch it:

```
curl -H "Authorization: Bearer islandora" http://idcp:localhost:8000/gemini/ab70127a-8579-4c17-af07-b3b1eceebb17
```

which should return

```
{
   "drupal":"http:\/\/idcp:localhost:8000\/node\/1",
   "fedora":"http:\/\/idcp:localhost:8080\/fcrepo\/rest\/ab\/70\/12\/7a\/ab70127a-8579-4c17-af07-b3b1eceebb17"
}
```

And to delete it:

```
curl -v -X DELETE -H "Authorization: Bearer islandora" http://localhost:8000/gemini/ab70127a-8579-4c17-af07-b3b1eceebb17
```

which should return

```
HTTP/1.1 204 No Content
Date: Mon, 29 Oct 2018 19:51:39 GMT
Server: Apache/2.4.18 (Ubuntu)
X-Powered-By: PHP/7.0.32-0ubuntu0.16.04.1
Cache-Control: no-cache, private
Content-Type: text/html; charset=UTF-8
```
