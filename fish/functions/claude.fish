function claude
  echo "Launching Claude under bash shell..."
  SHELL=/usr/bin/bash bash -c 'command claude "$@"' claude $argv
end
