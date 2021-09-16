#!/usr/bin/env bash
if [[ ! -d "~/terminus" ]]; then
  cd ~/
  mkdir terminus
  cd ~/terminus
  curl -O https://raw.githubusercontent.com/pantheon-systems/terminus-installer/master/builds/installer.phar
  php installer.phar install
  alias terminus=/home/circleci/terminus/vendor/bin/terminus
fi
