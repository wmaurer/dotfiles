Copy-Item -Path settings.json $home\AppData\Roaming\Code\User\
Copy-Item -Path keybindings.json $home\AppData\Roaming\Code\User\
Copy-Item -Path snippets $home\AppData\Roaming\Code\User -Recurse -Force
