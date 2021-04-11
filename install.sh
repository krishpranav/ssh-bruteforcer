#!/bin/bash
sudo apt-get update
sudo apt-get install gem
gem install net-ssh
gem install slop
sudo chmod +x ssh_bruteforcer.rb
echo "Installation Completed...!"