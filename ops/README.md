# Local Development Setup

## Need Help?

- See @timkelty or @jswewart
- https://gitlab.fusionary.com/fusionary/devops/ansible

## Prerequisites

- [Ansible](http://docs.ansible.com/ansible) >=2.4 (`brew install ansible` or `pip install ansible`)
- [Docker](https://www.docker.com/community-edition) (`brew cask install docker`)

## Get Started

1. **Ansible Vault Password**

  > Get the Ansible Vault password for this project (probably in Keybase), and write it to `ops/ansible/.vault_pass`:

  ```
  echo "replace-me" > ops/ansible/.vault_pass
  ```

2. **Provision and Build Environment**

  ```
  ansible-galaxy install -r ops/ansible/requirements.yml &&
  ops/ansible/bin/provision.sh local &&
  yarn docker-compose up -d &&
  yarn docker-compose run app composer install &&
  yarn &&
  yarn build
  ```

3. **Get a Database**

  ```
  yarn db pull development
  ```

4. **Start Developing**

  > Enjoy hot-module replacement/css live-reloading.

  ```
  yarn start
  ```
