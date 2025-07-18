# apache - php - xdebug

This docker container has a demo implementation of xdebug intended to be used in vscode, using windows and WSL

Be sure to install the official vscode extension called "PHP Debug" by Xdebug.

Note that in the docker-compose.yml file I am using port 8085, change it to 80 if you like.

## Trying to get XDEBUG running from vscode

The goal of this container is to be able to test the required configuration and required files in order to use xdebug

There are two ways I am trying to use xdebug here:

1: run the container and in vscode test if xdebug works [SUCCESS]

2: run the container and after starting vscode in this same directory, reopen the directory in WSL, then test if xdebug works [SUCCESS]

## Considerations

When I was testing the container using "WSL: Reopen Folder in WSL", I was getting an error when running Xdebug.

Before I did "WSL: Reopen Folder in WSL", I had the .vscode/launch.json file configured with pathMappings like:

```
"pathMappings": {
    "/var/www/html": "${workspaceFolder}/public"
}
```

But then, after I did "WSL: Reopen Folder in WSL", I tested an app that has the index.php file in directory called "public" (like Laravel) configured as the document root. All of the app's code was in a directory called CODE, so I changed the config in .vscode/launch.json to:

```
"pathMappings": {
    "/var/www/html": "${workspaceFolder}/CODE/public"
}
```

However, I was getting an error when listening to Xdebug and running the app, saying the file didn’t exist. The path it was trying to use to find the index.php file was:

```
${workspaceFolder}/public/CODE/public
```

It turns out that I had to change the config in .vscode/launch.json before I did "WSL: Reopen Folder in WSL" in order for the VS Code Xdebug extension to resolve the pathMappings correctly.

After going back using "WSL: Reopen Folder in Windows", I found the .vscode/launch.json file without the changes, so I reconfigured the pathMappings like this:

```
"pathMappings": {
    "/var/www/html": "${workspaceFolder}/CODE/public"
}
```

Then I did "WSL: Reopen Folder in WSL" again, run Xdebug, and then it worked.