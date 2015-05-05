# Docker container for websvn-centos6

This container definition is the prototype for a websvn application.
The websvn program provides graphical browsing of Subversion archives and
their histories.

**Note**

This project is not suitable for general use because of proxy considerations
during the build process. The Docker builder is a lot like Maven in that it's
expected to be able to build "write once/run anywhere" products. However,
unlike Maven, the Docker builder has not (so far) make the distinction between
the environment of the build process *versus* the environment of the runnable image.

Ideally, both build and run enviroments are totally portable, but in the Real World,
build machines often have specialized requirements such as the need to communicate
to the Internet via proxy servers with possible credentials that you **don't** want
hanging around in the Dockerfiles where anyone browsing the archives can read them.

There has been much discussion of late about providing a remedy for this situation,
and hopefully something will be added soon, but at this date (2015-05-04) Docker
releases up to and including version 1.6 do not have the ability to inject
this information into the build process. Hence there are site-specific "ENV" statements
in the Dockerfile that will probably need to be removed or altered for other build
environments.

Note also that the yum repository is a double-whammy, since it may be configured
for a proxy both at *build* time and at *run* time if you want to be able to apply
maintenance to an image. The yum application does not presently support setting
a proxy via the environment, which means that the /etc/yum.conf file in the image
has to have the proxy setting tacked on or removed and that, in turn becomes
part of the generated image.

## Configuration and use

Subversion archives to be served are designated in the /etc/websvn/config.php file. For convenience,
these designations can be simply appended to the end of the model confing.php file in this project.
The current generation of this Dockerfile merely copies in the hard-coded locations. A future
improvement could allow external runtime sources as well as mods to the Apache and php config files.

The model websvn.conf Apache config runs under the container's default host and allows all
access. Customize as needed.

To run, customize the Dockerfile, build the image and use a command in the form:

    docker run -d -p 9999:80 --name websvn <image_id>

where "9999" is the port on the Docker host where you wish this server to appear under
the URL: http://my.docker.host:9999/websvn

