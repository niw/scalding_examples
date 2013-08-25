Simple Scalding Examples
========================

This project contains very simple [Scalding](https://github.com/twitter/scalding) examples, test codes and a helper script to play with it.

Getting Started
---------------

Install [maven](http://maven.apache.org/), [zinc](https://github.com/typesafehub/zinc) (not required, but recommended.)

    $ brew install maven
    $ brew install zinc

Then, build jar packages. This ``mvm`` command will download all dependencies includes Scala, Scalding and Hadoop core.

    $ mvn -Pzinc clean package

Run a simple ``EchoJob`` which doesn't nothing, just copy input TSV data to output.

    $ echo "Hello\tWorld" > input
    $ src/main/scripts/run.sh --local EchoJob --in input --out output
    ...
    $ cat output
    Hello	World

There is another famous example.

    $ cat > input
    meow nyan purr
    purr nyan nyan
    $ src/main/scripts/run.sh --local WordCountJob --in input --out output
    ...
    $ cat output
    meow	1
    nyan	3
    purr	2

``run.sh`` is a very simple shell script to run Scalding job.
``--local`` option eventually gives ``--local`` to ``com.twitter.scalding.Tool`` which has ``main()`` to run jobs in local mode.

Run with Hadoop Cluster
-----------------------

### Install Hadoop on your local host

If you already have Hadoop, skip this section.

There are many Hadoop distributions, for now, pick [CDH](http://www.cloudera.com/content/cloudera/en/products/cdh.html).

    $ curl -O http://archive.cloudera.com/cdh/3/hadoop-0.20.2-cdh3u6.tar.gz
    $ cd /usr/local
    $ tar xzvf /path/to/hadoop-0.20.2-cdh3u6.tar.gz
    $ ln -s hadoop-0.20.2-cdh3u6 hadoop

Configure pseudo Hadoop cluster running on your local host.

    $ cd hadoop
    $ mv conf conf.original
    $ cp -Rp example-confs/conf.pseudo conf

Change `hadoop.tmp.dir` and `dfs.name.dir` to the better place (optional.)

    $ mkdir -p /usr/local/hadoop/var/cache
    $ cat | patch -p1
    --- a/conf/core-site.xml
    +++ b/conf/core-site.xml
    @@ -11,3 +11,3 @@
          <name>hadoop.tmp.dir</name>
    -     <value>/var/lib/hadoop-0.20/cache/${user.name}</value>
    +     <value>/usr/local/hadoop/var/cache/${user.name}</value>
       </property>
    --- a/conf/hdfs-site.xml
    +++ b/conf/hdfs-site.xml
    @@ -25,3 +25,3 @@
          <name>dfs.name.dir</name>
    -     <value>/var/lib/hadoop-0.20/cache/hadoop/dfs/name</value>
    +     <value>/usr/local/hadoop/var/cache/hadoop/dfs/name</value>
       </property>

Add ``/usr/local/hadoop/bin`` to ``PATH``, so that we can use ``hadoop`` command.

    $ export PATH=/usr/local/hadoop/bin:$PATH

Format HDFS.

    $ hadoop namenode -format

Then, run namenode, datanode, jobtracker and tasktracker.

    $ hadoop namenode
    $ hadoop datanode
    $ hadoop jobtracker
    $ hadoop tasktracker

### Run Scalding job on Hadoop cluster

Without ``--local``, ``run.sh`` uses ``haddop`` command and ``--hdfs`` option to run jobs on Hadoop cluster.

    $ cat > input
    meow nyan purr
    purr nyan nyan
    $ hadoop fs -put input input
    $ src/main/scripts/run.sh WordCountJob --in input --out output
    ...
    $ hadoop fs -cat 'output/part-*'
    meow	1
    nyan	3
    purr	2

``run.sh`` runs a job on Hadoop pseudo cluster then write output on HDFS.

### On real Hadoop cluster

To run a job, what we need is ``scalding_examples-….jar`` which contains job classes and ``scalding_examples-…-libjars.jar`` which contains all dependencies like Scala, Scalding etc but Hadoop dependencies (You don't often need to update this jar.) Then, use these jars with ``hadoop jar`` command and ``--libjars`` option.

See ``src/main/scripts/run.sh`` for more details.