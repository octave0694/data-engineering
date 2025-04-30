#### Installation et configuration de Spark
**Intsaller scala sur chaque nœud**
```shell
sudo apt install -y scala &&
scala -version
```

**Télécharger et extraire les binaires apache spark sur chaque nœud**
```shell
tar -xvf spark-3.5.5-bin-hadoop3.tgz
```

**Sur chaque nœud, déplacer les dossiers spark dans le répertoire /opt/spark et modifier les droits.**
```shell
sudo mv spark-3.5.5-bin-hadoop3 /opt/spark &&
sudo chown hadoop:root /opt/spark* -R &&
sudo chmod g+rwx /opt/spark* -R
```
**Ajouter le répertoire spark aux variables d'environnement, sur chaque noeud**
```shell
echo '
# For Spark
export PATH=$PATH:/opt/spark/bin
export SPARK_HOME=/opt/spark
' >> ~/.bashrc &&
source ~/.bashrc &&
echo $PATH $SPARK_HOME
```

**Editer le fichier spark-env.sh sur le noeud master.**

Renommer spark-env.sh.template en spark-env.sh
```shell
mv $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh
```

```shell
nano $SPARK_HOME/conf/spark-env.sh
```

```text
export SPARK_MASTER_HOST=master
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
```
**Editer le fichier workers sur le noeud namenode, pour y rajouter les noeuds worker.**

Renommer workers.template en workers
```shell
mv $SPARK_HOME/conf/workers.template $SPARK_HOME/conf/workers
```

```shell
nano $SPARK_HOME/conf/workers
```

```text
worker1
worker2
```

Pour définir une configuration par défaut des propriétés spark ainsi que les variables d'environnement, utiliser les fichiers suivants :

* spark-defaults.conf.template => spark-defaults.conf
* spark-env.sh

La configuration est terminée, nous pouvons démarrer spark.
```shell
$SPARK_HOME/sbin/start-all.sh
```

En allant sur l'URL http://192.168.44.140:8080/ on accède à l'interface de spark master.

#### Intégration de spark avec hive
**Editer le fichier de configuration `spark-defaults.conf` comme suit:**
```shell
nano $SPARK_HOME/conf/spark-defaults.conf
```
```text
spark.eventLog.enabled true
spark.eventLog.dir hdfs://master:9000/spark-logs
spark.history.fs.logDirectory hdfs://master:9000/spark-logs

#config for hive integration
spark.sql.warehouse.dir hdfs://master:9000/user/hive/warehouse
spark.sql.catalogImplementation hive
#spark.sql.hive.metastore.jars path
#spark.sql.hive.metastore.jars.path hdfs://master:9000/jars/*

spark.sql.hive.metastore.version 3.1.3
spark.hive.server2.webui.explain.output true
spark.hive.metastore.thrift.bind.host master
spark.hive.metastore.port 9083
spark.hive.metastore.uris thrift://master:9083
```