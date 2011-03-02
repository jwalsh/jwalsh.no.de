#!/bin/sh

# ps ax | grep "node app.js" | awk '{print $1}' | xargs -0 kill

node app.js
# open http://localhost:3000/
