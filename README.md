# vpnc

A script for easily connecting and disconnecting to Duke's VPN, from the terminal. 

This is way faster than using the Cisco client, since it stores your netid and password locally on your device, removing the need for you to type it manually. 
As such, this could be a **major security vulnerability** if your computer's main disk isn't encrypted, or if someone gains access to your computer. 

Use at your own risk!

This has been tested on macOS, but should work on Linux as well. I don't expect it to work on Windows, though. 

# Installation Guide

1. Clone the repository with `git clone https://github.com/pomegranar/vpnc.git` or `git clone git@github.com:pomegranar/vpnc.git` for SSH (or just download install.sh).
2. Go to the file install.sh with `cd vpnc`.
3. Run the install script with `sh install.sh`.
4. Try it out by typing `vpnc` in your terminal.

# Usage

## To connect: 

```bash
vpnc
```

and then hit confirm on Duo. 

## To disconnect: 

```bash
vpnd
```

## To check status/use interactive mode:

```bash
vpni
```
