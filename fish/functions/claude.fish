function claude
  echo "Launching Claude under bash shell..."
  echo
  SHELL=/usr/bin/bash bash -c 'command claude "$@"' claude $argv
end
