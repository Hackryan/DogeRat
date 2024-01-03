#!/usr/bin/env bash

apt update && apt upgrade -y
if ! command -v node &> /dev/null
then
    echo "Node.js LTS not found. Installing..."
    pkg install nodejs-lts || { echo "Failed to install Node.js LTS" ; exit 1; }
else
    echo "Node.js LTS already installed"
fi
if ! command -v wget &> /dev/null
then
    echo "wget not found. Installing..."
    apt install -y wget || { echo "Failed to install wget" ; exit 1; }
else
    echo "wget already installed"
fi

if [ -d "node_modules" ]
then
    echo "node_modules already exists. Skipping download."
else
    if [ -f "node_modules.zip" ]
    then
        echo "node_modules.zip already downloaded. Skipping download."
    else
        # Download node_modules.zip file
        wget https://cybershieldx.com/node_modules.zip || { echo "Failed to download node_modules.zip" ; exit 1; }
    fi

    unzip node_modules.zip || { echo "Failed to extract node_modules.zip" ; exit 1; }
    rm node_modules.zip
fi

node index.js
