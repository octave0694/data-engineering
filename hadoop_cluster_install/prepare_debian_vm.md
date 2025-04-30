#### 0- Préparation d'un cluster hadoop avec 4 noeuds
Notre cluster hadoop sera composé de 4 noeuds: un noeud principal qui servira de `name node HDFS`/` YARN Resource Manager` et 3 `data nodes HDFS`/`YARN Node Manager`.
#### 1- Configuration du système
Les machines seront configurées comme suit:

* Debian 12.10.0
* Hadoop 3.4.1
* Hive 4.0.1
* Java 8

- Name node
    * CPU/RAM/DISK : 2CPU/2GB/20GB
    * Adresse IP : 192.168.44.140
    * hostname : namenode
    * user : hadoop
    * pwd : hadoopwd
- Data node1
    * CPU/RAM/DISK : 2CPU/2GB/20GB
    * Adresse IP : 192.168.44.141
    * hostname : datanode1
    * user : hadoop
    * pwd : hadoopwd
- Data node2
    * CPU/RAM/DISK : 2CPU/2GB/20GB
    * Adresse IP : 192.168.44.142
    * hostname : datanode2
    * user : hadoop
    * pwd : hadoopwd
- Data node2
    * CPU/RAM/DISK : 2CPU/2GB/20GB
    * Adresse IP : 192.168.44.143
    * hostname : datanode3
    * user : hadoop
    * pwd : hadoopwd

#### 2- Installation
Installer le système Debian sur la première machine qui servira de name node. Lors de l'installation, il faut cocher l'installation automatique de SSH server.
Une fois l'installation terminée, réaliser les actions suivantes :

```shell
su
```
````shell
apt-get install sudo -y
````
````shell
apt install net-tools -y
````
````shell
apt install unzip
````
````shell
apt install curl
````
````shell
apt install wget -y
````
````shell
wget http://www.mirbsd.org/~tg/Debs/sources.txt/wtf-bookworm.sources
````
````shell
mv wtf-bookworm.sources /etc/apt/sources.list.d/
````
```shell
apt upgrade
```
```shell
apt update
```
Ajouter /urs/sbin au PATH
````shell
export PATH=$PATH:/usr/sbin
````

Ajouter un nouvel utilisateur **hadoop** et le rajouter au group sudo
````shell
adduser hadoop
usermod -aG hadoop hadoop
adduser hadoop sudo
````
Redémarrer la machine avant de continuer la procédure.
Après redémarrage, il faut se connecter en tant qu'utilisateur hadoop.

Installation de java 8
```shell
apt install -y openjdk-8-jdk
```
````shell
java -version
````
exporter la variable d'environnement **JAVA_HOME**
```shell
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> ~/.bashrc
```

```shell
source ~/.bashrc
```

Télécharger les binaires hadoop
```shell
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.1/hadoop-3.4.1.tar.gz
```
Télécharger les binaires apache spark
```shell
wget https://dlcdn.apache.org/spark/spark-3.5.5/spark-3.5.5-bin-hadoop3.tgz
```
Télécharger les binaires apache hive
```shell
wget https://dlcdn.apache.org/hive/hive-4.0.1/apache-hive-4.0.1-bin.tar.gz
```

Une fois les prérequis installés, nous pouvons faire un snapshot de la machine virtuelle puis réaliser des clones, qui serviront à configurer les data nodes.

#### 3- Configuration réseau
Mettre les 3 machines dans un même VM-network. Au démarrage, se connecter avec l'utilisateur hadoop puis éditer la configuration des machines.
* **hadoop-namenode**
```shell
sudo hostnamectl set-hostname hadoop-namenode
sudo nano /etc/network/interfaces
#iface ens33  inet static
# address 192.168.44.140
# netmask 255.255.255.0
# gateway 192.168.44.2

sudo systemctl restart networking.service
sudo systemctl status networking.service
```

* **hadoop-datanode1**
```shell
sudo hostnamectl set-hostname hadoop-datanode1
sudo nano /etc/network/interfaces
#iface ens33  inet static
# address 192.168.44.141
# netmask 255.255.255.0
# gateway 192.168.44.2

sudo systemctl restart networking.service
sudo systemctl status networking.service
```

* **hadoop-datanode1**
```shell
sudo hostnamectl set-hostname hadoop-datanode2
sudo nano /etc/network/interfaces
#iface ens33  inet static
# address 192.168.44.142
# netmask 255.255.255.0
# gateway 192.168.44.2

sudo systemctl restart networking.service
sudo systemctl status networking.service
```

* **hadoop-datanode1**
```shell
sudo hostnamectl set-hostname hadoop-datanode3
sudo nano /etc/network/interfaces
#iface ens33  inet static
# address 192.168.44.143
# netmask 255.255.255.0
# gateway 192.168.44.2

sudo systemctl restart networking.service
sudo systemctl status networking.service
```

Editer le ficher /etc/hosts sur chaque machine
```shell
sudo nano /etc/hosts
192.168.44.140 hadoop-namenode
192.168.44.141 hadoop-datanode1
192.168.44.142 hadoop-datanode2
192.168.44.142 hadoop-datanode3
```

#### 4- Communication ssh entre les noeuds
Hadoop a besoin qu'une communication ssh soit fonctionnelle entre les noeuds. Pour cela, on génère une clé ssh sur le namenode et on la copie sur tous les noeuds.
```shell
ssh-keygen
```

```shell
ssh-copy-id hadoop@hadoop-namenode
ssh-copy-id hadoop@hadoop-datanode1
ssh-copy-id hadoop@hadoop-datanode2
ssh-copy-id hadoop@hadoop-datanode3
```