up:
  docker compose up -d
down:
  docker compose down

clean: down
  #!/usr/bin/env bash
  for dir in data/wp*/; do
    if [ -d "$dir" ]; then
      rm -rf $dir/*
    fi
  done

alias sh := shell
shell CONTAINER:
  docker compose exec -it {{CONTAINER}} sh

reload CONTAINER:
  docker compose down {{CONTAINER}}
  docker compose up -d {{CONTAINER}}

set-domain DOMAIN:
  @sed -i '' 's/wp.local.terrible.dentist/{{DOMAIN}}/g' data/wordpress.sql
  @echo 'WP domain set to: {{DOMAIN}}'