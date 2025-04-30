#### Installation et configuration de hadoop

Désarchiver hadoop sur chaque noeud et déplacer le dossier hadoop-3.4.1 dans /opt/.
```shell
sudo tar -xvf hadoop-3.4.1.tar.gz && sudo mv hadoop-3.4.1 /opt/hadoop && sudo chown hadoop:root /opt/hadoop* -R && sudo chmod g+rwx /opt/hadoop* -R
```

Ajouter hadoop à la variable $PATH sur chaque noeud.
```shell
echo 'export PATH=$PATH:/opt/hadoop/bin:/opt/hadoop/sbin' >> ~/.bashrc && source ~/.bashrc
```
```shell
echo $PATH
```
Exporter les variables d'environnements Hadoop sur tous les noeuds.
```shell
echo '
# Bash Variables for Hadoop
export HADOOP_HOME="/opt/hadoop"
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
' >> ~/.bashrc
```
```shell
source ~/.bashrc
```
```shell
echo $HADOOP_HOME $HADOOP_COMMON_HOME $HADOOP_CONF_DIR $HADOOP_HDFS_HOME $HADOOP_MAPRED_HOME
```

On configure le noeud hadoop-namenode puis on tranfert les fichiers de configuration sur les worker.

**Editer le fichier core-site.xml**
```shell
nano $HADOOP_HOME/etc/hadoop/core-site.xml
```
```xml
<configuration>
	<property>
		<name>fs.default.name</name>
		<value>hdfs://hadoop-namenode:9000</value>
	</property>
    <property>
        <name>fs.trash.interval</name>
        <value>3000</value>
    </property>
    <property>
        <name>fs.trash.checkpoint.interval</name>
        <value>60</value>
    </property>
</configuration>
```

**Editer le fichier hdfs-site.xml**
```shell
nano $HADOOP_HOME/etc/hadoop/hdfs-site.xml
```
```xml
<configuration>
  <property>
    <name>dfs.namenode.name.dir</name>
    <value>/opt/hadoop/data/nameNode</value>
  </property>
  <property>
    <name>dfs.datanode.data.dir</name>
    <value>/opt/hadoop/data/dataNode</value>
  </property>
  <property>
    <name>dfs.replication</name>
    <value>3</value>
  </property>
  <property>
    <name>dfs.webhdfs.enabled</name>
    <value>true</value>
  </property>
  <property>
    <name>dfs.permissions</name>
    <value>false</value>
  </property>
</configuration>
```

**Editer le fichier hadoop-env.sh pour rajouter la ligne suivante:**
```shell
nano $HADOOP_HOME/etc/hadoop/hadoop-env.sh
```
```text
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
```


**Editer le fichier workers pour y rajouter le hostname des noeuds worker.**
```shell
nano $HADOOP_HOME/etc/hadoop/workers
```
```text
hadoop-datanode1
hadoop-datanode2
hadoop-datanode3
```

Une fois les fichiers bien configurés, on les copie sur les noeuds worker.
```shell
scp  $HADOOP_HOME/etc/hadoop/* hadoop-datanode1:$HADOOP_HOME/etc/hadoop/ &&
scp  $HADOOP_HOME/etc/hadoop/* hadoop-datanode2:$HADOOP_HOME/etc/hadoop/ &&
scp  $HADOOP_HOME/etc/hadoop/* hadoop-datanode3:$HADOOP_HOME/etc/hadoop/
```

Tout est prêt. Nous pouvons maintenant formater le système de fichier hdfs puis démarrer hdfs.
```shell
hdfs namenode -format
```
```shell
$HADOOP_HOME/sbin/start-dfs.sh
```

Si toutes les configurations sont bonnes, HADOOP est démarré et on peut lancer la commande JPS sur chaque noeud pour vérifier les process.
```shell
jps
```
En allant sur l'URL http://192.168.44.140:9870/ on accède à l'interface web de hdfs.