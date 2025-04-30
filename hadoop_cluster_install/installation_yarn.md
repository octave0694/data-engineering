#### Installation et configuration de YARN
YARN est constitué de deux composants:
* Resource manager qui s'exécute sur le main node
* Node manager qui est un agent qui s'exécute sur chaque noeud worker

**Sur chaque noeud, exporter la variable HADOOP_YARN_HOME.**
```shell
echo '# Bash Variables for Yarn
export HADOOP_YARN_HOME=$HADOOP_HOME' >> ~/.bashrc &&
source ~/.bashrc &&
echo $HADOOP_YARN_HOME
```

**Sur le noeud master, il faut editer le fichier yarn-site.xml**
```shell
nano $HADOOP_HOME/etc/hadoop/yarn-site.xml
```
```xml
<configuration>
	<property>
		<name>yarn.resourcemanager.hostname</name>
		<value>master</value>
	</property>
	<property>
        <name>yarn.webapp.ui2.enable</name>
        <value>true</value>
    </property>
</configuration>
```

**Ensuite transférer le fichier yarn-site.xml sur les noeuds worker.**
```shell
scp $HADOOP_HOME/etc/hadoop/yarn-site.xml hadoop-datanode1:$HADOOP_HOME/etc/hadoop/yarn-site.xml &&
scp $HADOOP_HOME/etc/hadoop/yarn-site.xml hadoop-datanode2:$HADOOP_HOME/etc/hadoop/yarn-site.xml &&
scp $HADOOP_HOME/etc/hadoop/yarn-site.xml hadoop-datanode3:$HADOOP_HOME/etc/hadoop/yarn-site.xml
```

**Nous pouvons maintenant démarrer YARN.**
```shell
$HADOOP_HOME/sbin/start-yarn.sh
```
**Pour vérifier que tout est ok, on peut afficher la liste des noeuds yarn**
```shell
yarn node --list
```

En allant sur l'URL http://192.168.44.140:8088/ on accède à l'interface de yarn.