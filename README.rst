=============
memote-docker
=============

Easily run the memote command line tools from a docker container.


Installation
============

We aim to release containers for every memote release from version 0.4.5
onwards. You can thus use a specific version tag or simply 'latest'.

.. code-block:: console

    $ docker pull opencobra/memote:latest

Usage
=====

The container exposes the memote command line tool directly. If you run the
container without any arguments you will see the base help message.

.. code-block:: console

    $ docker run opencobra/memote

We are currently working on allowing you to pipe the model to the docker
container. So in future you will be able to do the following.

.. code-block:: console

    $ my-model.xml > docker run opencobra/memote run

Please note that any other files created by memote, such as the report or
results files, are located inside the container. Thus the container is most
useful to look at the command line output. You can copy the files from the
container to your system but it is a rather cumbersome process.

Contact
=======

For comments and questions get in touch via

* our `gitter chatroom <https://gitter.im/opencobra/memote>`_
* or our `mailing list <https://groups.google.com/forum/#!forum/memote>`_.

Are you excited about this project? Consider `contributing
<https://memote.readthedocs.io/en/latest/contributing.html>`_ by adding novel
tests, reporting or fixing bugs, and generally help us make this a better
software for everyone.

Copyright
=========

* Copyright (c) 2017, Novo Nordisk Foundation Center for Biosustainability,
  Technical University of Denmark.
* Free software: `Apache Software License 2.0 <LICENSE>`_

