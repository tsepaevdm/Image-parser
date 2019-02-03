#!/bin/bash

aliases="\
alias sv='sudo vim'
alias upd='sudo apt update'
alias upg='sudo apt upgrade -y'
alias upg+='sudo apt update; sudo apt upgrade -y'
alias ins='sudo apt install'
"

echo -e "$aliases\n$(cat ~/.bashrc)" > ~/.bashrc

echo -e "\n%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers