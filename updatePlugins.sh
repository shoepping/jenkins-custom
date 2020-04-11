#!/bin/bash

TODAY=`date +%m.%d`

git commit -m "${TODAY}, plugins update" plugins.txt
git push origin master
