# Dev Ops Stack with Docker

## Introduction

This docker stack contains all the basics tools to deploy a developement/CI stack on your own server.

It includes the following tools:

* GitLab CE Edition
* Jenkins with BlueOcean and default GitLab plugin
* OpenLDAP
* PHP LDAP Admin
* Nginx & Ftp server

You can manage all the stack with the include cli.

To see the available options juste write:

```bash
 ./mains.sh --help
```

Every sub command has it own help too.

```bash
./mains.sh COMMAND --help
```

Available command are:

* restart
* start
* stop

### Nginx and Ftp

The goal of the Ftp and Nginx is to provide a way to push any artifact on the ftp server and get them trhough http request via nginx.

The main folder is releases ans it's directly mounted from disk into the docker container.

The nginx is already pre-configured to serve all the content in the releases folder.

## Configuration

Before running docker-compose command or our cli, make sure you have configured the stack properly.

### The LDAP & GitLab

the `.env` file contains basics var to setup the LDAP. Just open it and replace the var value with your own value.

Then go to config folder and open the file `gitlab.rb`.

Search theese two lines and uncomment them with your own value from the LDAP.

```ruby
  # bind_dn: 'CN=admin,DC=organisation,DC=com'
  # password: '${YOUR_PASSWORD}'
```

For more informations you can check out the [GitLab documentation](https://docs.gitlab.com/omnibus/settings/configuration.html) to change anything you want in this file.

For the FTP a default user jenkins is added with a default hash visible in the file `ftp/Dockerfile`.

 **It's strongly recommanded to generate your own hash!**

You can later add the jenkins credentials in your GitLab to publish artifact with GitLab in the ftp server.

## Start the stack

Now you are ready to launch the stack. Just write

```bash
./mains.sh run
```

The first time and every time you need to make some modification in the LDAP you can use the PHP LDAP Admin web interface (in a separate container) with the option -A.

```bash
./mains.sh run -A
```

Now opened your browser at the following address
`https://localhost:443/`

By default the interface is not started for safety reason. Shutdown this container once you've done!

If you need to rebuild the stack from the image, to upgrade a version for exemple, start or restart the stack with the docker build option:

```bash
./mains.sh run -b
```