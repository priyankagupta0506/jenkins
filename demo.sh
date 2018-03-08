#!/bin/bash

free -m 
echo "memory check"
netstat -anltp | grep 8080
echo "jenkins check"
