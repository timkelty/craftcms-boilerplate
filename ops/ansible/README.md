# Craft/Docker Deployment

- Requires Ansible 2.4 or newer (`brew install ansible` or `pip install ansible`)
- Expects Debian/Ubuntu hosts
- Expects that you have ssh-agent running and have a key installed as the root user

These playbooks deploy a configuration that installs docker, gitlab-runner and a few other goodies.
Also included is a local development environment that uses docker-compose as it's base.


## Local Development

* Copy the entire `ansible` folder into the `ops` folder of your project.
* From your project root `cd ops/ansible`

edit `group_vars/all/settings.yml`:
    
* change `app_identifier` to the name of your app.
* change `gitlab_registry_url` to the docker registry URL found in the gitlab project.

edit `group_vars/local/settings.yml`:

* `nginx_port`
* `nginx_ssl_port`
* `blackfire_client_id`
* `blackfire_client_token`
* `gitlab_ci_prod_url`
* `gitlab_ci_dev_url`
    
Then run `ansible-playbook -e "env=local" develop.yml` in the `ansible` folder. This will bootstrap your configuration and build your docker images. Takes a while, so go grab a coffee while you're waiting. Note: This task can also be run by typing `bin/provision.sh local`

### Importing an existing mysql dumpfile

If you have an existing mysql dumpfile to import, copy it into `ops/docker/mysql-import`. Remember to remove it after the containers are started, otherwise docker will bootstrap this set of data every time.


### Starting the project

* cd into `ops/docker`
* `docker-compose up -d`

## Deploying the application

We are using gitlab-ci to build and deploy the app. In order to deploy, you simply have to tag and push the release.
There's a script that does this for you:

    ./ops/ansible/bin/release.sh development

## Provisioning a new server

* Edit the `hosts/production` and `hosts/development` (if applicable) files to include the IP addresses and hostnames of the remote hosts.
* Obtain the `.vault_pass` file from keybase and place it in `ops/ansible`
* in `group_vars/production/settings.yml`, and `group_vars/development/settings.yml` change server_names to be the domain names of your app.


### Edit the vault files

The vault doesn't yet exist on new sites, these commands will create it.

* `ansible-vault edit group_vars/development/vault.yml` 
* `ansible-vault edit group_vars/production/vault.yml` 

Set the following vars:

* `vault_mysql_password`
* `vault_mysql_root_password`
* `vault_craft_security_key`

### Install dependencies from ansible galaxy

    ansible-galaxy install -r requirements.yml
    
### Setting up Tarsnap

We need to create a tarsnapper.conf and a key for each server:

`"~/.tarsnap/tarsnap.{{ app_identifier }}.{{ stage }}.key"`
`"~/.tarsnap/tarsnapper.{{ app_identifier }}.{{ stage }}.conf"`

### Setting up gitlab-runner

Before we provision, we need to get a token for our gitlab project. Consult the latest gitlab-ci documentation for that.
Once you have the token:

    export GITLAB_RUNNER_REGISTRATION_TOKEN=<your project token>
    
See https://github.com/riemers/ansible-gitlab-runner for more info

### Run the provisioning scripts

    ansible-playbook server.yml -l yourserver.fusionary.com -e "env=<environment>"
    
or:

    bin/provision.sh <environment>
