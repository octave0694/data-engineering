#### Installation et configuration de hive
Hive est un Data Warehouse qui stocke les données sur Hadoop.
 Version Hive : 4.0.1

* [Tuto installation Hive](https://phoenixnap.com/kb/install-hive-on-ubuntu)
* [Apache Hive (A Complete Journey)](https://medium.com/@zaman.nuces/apache-hive-a-brief-introduction-series-1-of-3-54ec07753dd2)
* [Hive Setup with Spark Exection and Spark HiveContext](https://github.com/chuqbach/Big-Data-Installation/blob/master/Hive%20Setup%20with%20Spark%20Exection%20and%20Spark%20HiveContext.md)

#### Installation de mysql qui servira de metastore
```shell
sudo apt install gnupg -y &&
wget https://dev.mysql.com/get/mysql-apt-config_0.8.30-1_all.deb &&
sudo dpkg -i mysql-apt-config_0.8.30-1_all.deb &&
sudo apt update &&
sudo apt install mysql-server -y
```

**création d'un utilisateur mysql**
```shell
sudo mysql -u root -p
```
```shell
create user 'hive'@'%' identified by 'hive';
```
```shell
grant create user, reload on *.* to 'hive'@'%';
```
```shell
grant all on *.* to 'hive'@'%' with grant option;
```
```shell
grant create, select on *.* to 'hive'@'%';
```
```shell
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'%';
```
```shell
FLUSH PRIVILEGES;
```
```shell
exit
```

**Télécharger le jar mysql-driver et le copier dans le dossier $HIVE_HOME/lib**
```shell
wget https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.2.0/mysql-connector-j-8.2.0.jar
```
```shell
 cp mysql-connector-j-8.2.0.jar $HIVE_HOME/lib/
```

Une fois mysql installé et configuré, on passe à l'installation de hive. L'installation de hive se fera uniquementsur le namenode.
**Télécharger et extraire les binaires apache hive**
```shell
tar xvzf apache-hive-4.0.1-bin.tar.gz
```

**Déplacer le dossier hive vers le répertoire /opt/hive et modifier les droits d'accès**
```shell
sudo mv apache-hive-4.0.1-bin /opt/hive &&
sudo chown hadoop:root /opt/hive* -R &&
sudo chmod g+rwx /opt/hive* -R
```

**Ajouter les variables d'environnements**
```shell
echo '
# For Hive
export HIVE_HOME=/opt/hive
export PATH=$PATH:$HIVE_HOME/bin
' >> ~/.bashrc &&
source ~/.bashrc &&
echo $HIVE_HOME $PATH
```

**Editer le fichier core-site.xml et rajouter une nouvelle configuration**
```shell
nano $HADOOP_HOME/etc/hadoop/core-site.xml
```
`hadoop` est le nom du user qui sera utiliser la connexion avec hive.
```xml
<property>
    <name>hadoop.proxyuser.hadoop.groups</name>
    <value>*</value>
</property>
<property>
    <name>hadoop.proxyuser.hadoop.hosts</name>
    <value>*</value>
</property>
<property>
    <name>hadoop.proxyuser.server.hosts</name>
    <value>*</value>
</property>
<property>
    <name>hadoop.proxyuser.server.groups</name>
    <value>*</value>
</property>
```

Hive a besoin de certains répertoires pour fonctionner, nous allons les créer sur hdfs.

* /tmp : pour stocker les résultats intermédiraire des process Hive
* /user/hive/warehouse : répertoire de stockage par défaut des bases de données hive

```shell
hadoop fs -mkdir /tmp &&
hadoop fs -chmod g+w /tmp &&
hadoop fs -mkdir -p /user/hive/warehouse &&
hadoop fs -chmod g+w /user/hive/warehouse &&
hadoop fs -ls / &&
hadoop fs -ls /user/hive
```

**Editer le fichier hive-site.xml**
```shell
nano $HIVE_HOME/conf/hive-site.xml
```
```shell
<configuration>
    <property>
        <name>hive.metastore.warehouse.dir</name>
        <value>/user/hive/warehouse</value>
    </property>
    <property>
        <name>hive.server2.webui.explain.output</name>
        <value>true</value>
    </property>
    <property>
        <name>hive.metastore.thrift.bind.host</name>
        <value>master</value>
    </property>
    <property>
        <name>hive.metastore.port</name>
        <value>9083</value>
    </property>
    <property>
        <name>hive.execution.engine</name>
        <value>tez</value>
    </property>
</configuration>
```

Configuration à rajouter pour un remote metastore
```shell
    <property>
        <name>javax.jdo.option.ConnectionURL</name>
        <value>jdbc:mysql://master/metastore?createDatabaseIfNotExist=true</value>
        <description>metadata is stored in a MySQL server</description>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <value>com.mysql.cj.jdbc.Driver</value>
        <description>MySQL JDBC driver class</description>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionUserName</name>
        <value>hive</value>
        <description>user name for connecting to mysql server</description>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionPassword</name>
        <value>hive</value>
        <description>password for connecting to mysql server</description>
    </property>
    <property>
        <name>hive.metastore.uris</name>
        <value>thrift://master:9083</value>
    </property>
```

Par défaut, hive utilise une base de données derby pour créer le métastore. Il est possible d'utiliser un RDMS comme MYSQL ou POSTGRES pour créer le métastore. Ici, nous allons utiliser MYSQL.

Nous allons initer la création du schéma métastore avec mysql

```shell
$HIVE_HOME/bin/schematool -dbType mysql -initSchema
```

Une fois l'initialisation terminée, ou lance un autre terminal pour démarrer le service métastore puis ensuite hiverserver2 .

```shell
hive --service metastore &
```

```shell
$HIVE_HOME/bin/hiveserver2 &
```
Une fois que les log affichent Hive Session ID = 5f3754b9-6819-425e-99f9-1f2d00143719, hive est bien lancé.

L'interface web de hiveserver est accessible par défaut via http://192.168.44.140:10002/.

On peut utiliser beeline pour ouvrir une session SQL.
```shell
$HIVE_HOME/bin/beeline -n hadoop -u jdbc:hive2://master:10000
```
