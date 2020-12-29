#!/bin/bash

TODAY=`date +%y.%m.%d`

git commit -m "${TODAY}, plugins update" plugins.txt
git push origin master
