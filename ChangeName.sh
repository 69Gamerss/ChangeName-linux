#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Check if a new hostname is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 new-hostname"
  exit 1
fi

# Store the new hostname
NEW_HOSTNAME=$1

# Update the /etc/hostname file
echo $NEW_HOSTNAME > /etc/hostname

# Update the /etc/hosts file
sed -i "s/127.0.1.1 .*/127.0.1.1 $NEW_HOSTNAME/" /etc/hosts

# Set the new hostname immediately
hostnamectl set-hostname $NEW_HOSTNAME

# Display a message indicating the hostname has been changed
echo "Hostname changed to $NEW_HOSTNAME. You may need to reboot for all changes to take effect."

sudo exec bash

exit 0


###  wget -qO- https://raw.githubusercontent.com/69Gamerss/ChangeName-linux/main/ChangeName.sh | sudo bash -s -- <Hostname>
