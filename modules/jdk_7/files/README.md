Missing JDK RPM File?
=====================

Oracle JDK 1.7 is distributed as rpm, however, it's not in the yum repository.

You need manually download ``jdk-7u67-linux-x64.rpm`` from [Oracle web page](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html) and place it here.

See ``modules/jdk/manifests/init.pp`` as well.