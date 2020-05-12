---

fedora_base_url: http://fedora:8080/fcrepo/rest

debug: True

log:
  # Valid log levels are:
  # DEBUG, INFO, NOTICE, WARNING, ERROR, CRITICAL, ALERT, EMERGENCY, NONE
  # log level none won't open logfile
  level: {{getv "/gemini/log/level"}}
  file: /var/log/islandora/gemini.log

syn:
  # toggles JWT security for service
  enable: true
  # Path to the syn config file for authentication.
  # example can be found here:
  # https://github.com/Islandora/Syn/blob/master/conf/syn-settings.example.xml
  config: ../syn-settings.xml

db.options:
  driver: {{getv "/gemini/db/driver"}}
  host: {{getv "/gemini/db/host"}}
  port: {{getv "/gemini/db/port"}}
  dbname: {{getv "/gemini/db/name"}}
  user: {{getv "/gemini/db/user"}}
  password: {{getv "/gemini/db/password"}}
