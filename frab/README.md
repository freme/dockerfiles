frab conference management system docker image
==============================================

Using an ubuntu 16.04 and a manually installed, passenger-enabled nginx, this image sets up a frab installation using a linked mariadb-container.

Build the Image
===============

* Execute *./make* to build the image yourself.

Configuration
=============

* Edit *env*
* Rename *env* to *.env*

Run Container
=============

* Execute *./run*

The container is configured during startup using the *init.sh* script. To add the new version to the Dockerimage, run *docker build --tag=my/name:latest .* and then stop/start the container.

Import Data
===========

* Execute *./import*

Export Data
===========

* Execute *./export*

Stop Container
==============

* Execute *.stop*

Log Files
=========

* Run an interactive session to watch the logs

    docker exec -ti frab /bin/bash
    export TERM=vt100
    tail -f log/production.log

* Vim is installed should you need an editor
