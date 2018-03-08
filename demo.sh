#!/bin/bash

free -m 
echo "memory check"
sudo netstat -anltp | grep 8080
echo "jenkins check"
