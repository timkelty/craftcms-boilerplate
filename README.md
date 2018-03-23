# Craft CMS Boilerplate

Opinionated boilerplate configuration of Craft CMS.

## Features

- Ansible/Docker environment provisioning
- CI/CD Deployments via [Gitlab CI/CD](https://about.gitlab.com/features/gitlab-ci-cd/)
- Front-end asset building via [Neutrino](https://neutrino.js.org/)
- Bootstrapped and configured using [Craft CMS Bootstrap](https://github.com/timkelty/craftcms-bootstrap)

## Development Quickstart

### Prerequisites

- [Ansible](http://docs.ansible.com/ansible) >=2.4 (`brew install ansible` or `pip install ansible`)
- [Docker](https://www.docker.com/community-edition) (`brew cask install docker`)

### Getting Started

1. **Create New Project**

  ```
  composer create-project fusionary/craftcms-boilerplate my-project && cd my-project
  ```

2. **Grab the lastest DevOps goodies**

  ```
  rm -rf ops/ansible &&
  git clone https://gitlab.fusionary.com/fusionary/devops/ansible.git ops/ansible &&
  rm -rf ops/ansible/.git
  ```

3. **Ansible Vault Password**

  > Get the Ansible Vault password for this project (probably in Keybase), and write it to `ops/ansible/.vault_pass`:

  ```
  echo "replace-me" > ops/ansible/.vault_pass
  ```

4. **Provision and Build Environment**

  ```
  ansible-galaxy install -r ops/ansible/requirements.yml &&
  ops/ansible/bin/provision.sh local &&
  yarn docker-compose up -d &&
  yarn docker-compose run app composer install &&
  yarn &&
  yarn build
  ```

4. **Get a Database**

  ```
  yarn db pull development
  ```

5. **Start Developing**

  > Enjoy hot-module replacement/css live-reloading.

  ```
  yarn start
  ```

### More Info

- [Full Setup Docs](./ops/README.md)
- See @timkelty or @jswewart
- https://gitlab.fusionary.com/fusionary/devops/ansible
