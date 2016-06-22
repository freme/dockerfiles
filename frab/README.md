frab conference management system docker image
==============================================

Using an ubuntu 16.04 and a manually installed, passenger-enabled nginx, this image sets up a frab installation using a linked mariadb-container.

Build the Image
===============

* Execute *./make*

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

