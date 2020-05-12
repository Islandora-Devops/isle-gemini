CREATE DATABASE IF NOT EXISTS {{getv "/gemini/db/name"}} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '{{getv "/gemini/db/user"}}'@'%' IDENTIFIED BY '{{getv "/gemini/db/password"}}';
GRANT ALL PRIVILEGES ON {{getv "/gemini/db/name"}}.* to '{{getv "/gemini/db/user"}}'@'%';
FLUSH PRIVILEGES;
