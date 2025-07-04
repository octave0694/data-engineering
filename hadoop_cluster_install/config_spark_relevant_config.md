These are some useful relevant spark configuration properties.  
[Viewing and setting apache spark configuration.](https://medium.com/@nikaljeajay36/viewing-and-setting-apache-spark-configurations-bde06ed13def)

`spark.app.name`**  
`spark.master`**   
`spark.driver.cores`**  
`spark.driver.memory`**  
`spark.executor.memory`**  
`spark.executor.cores`**  
`spark.ui.enabled`**  
`spark.ui.killEnabled`**  
`spark.ui.port`**  
`spark.broadcast.compress`**  
`spark.checkpoint.compress`**  
`spark.serializer`**  
`spark.files.maxPartitionBytes`**  
`spark.sql.adaptive.enabled`**  
`spark.sql.cbo.enabled`**  
`spark.sql.files.maxPartitionBytes`**  
`spark.sql.files.maxPartitionNum`**  
`spark.sql.files.maxRecordsPerFile`**  
`spark.sql.files.minPartitionNum`**  
`spark.sql.shuffle.partitions`**  
`spark.sql.ui.explainMode`**  
`spark.sql.warehouse.dir`**  
`spark.default.parallelism`**  
`spark.eventLog.enabled`**  
`spark.eventLog.dir`**  
`spark.history.fs.logDirectory`** : export SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory=hdfs://master:9000/spark_logs"  
`spark.sql.extensions`**  
`spark.sql.catalog.spark_catalog`**  

`spark.driver.host`  
`spark.driver.port`  
`spark.driver.log.dfsDir`  
`spark.driver.log.layout`  
`spark.driver.extraClassPath`  
`spark.driver.defaultJavaOptions`  
`spark.driver.extraJavaOptions`  
`spark.driver.extraLibraryPath`  
`spark.driver.userClassPathFirst`  

`spark.executor.extraClassPath`  
`spark.executor.defaultJavaOptions`  
`spark.executor.extraJavaOptions`  
`spark.executor.extraLibraryPath`  
`spark.executor.heartbeatInterval`  

`spark.local.dir`  
`spark.logConf`  
`spark.log.level`  
`spark.jars`  
`spark.jars.packages`  
`spark.jars.excludes`  
`spark.jars.repositories`  

`spark.ui.showConsoleProgress`  

`spark.io.compression.codec`  
`spark.rdd.compress`  

`spark.broadcast.blockSize`  
`spark.broadcast.checksum`

`spark.files.ignoreCorruptFiles`  
`spark.files.ignoreMissingFiles`  

`spark.cores.max`  

`spark.sql.ansi.enabled`  

`spark.sql.charAsVarchar`  
`spark.sql.cli.print.header`  
`spark.sql.columnNameOfCorruptRecord`  
`spark.sql.csv.filterPushdown.enabled`  
`spark.sql.datetime.java8API.enabled`  
`spark.sql.defaultCatalog`  
`spark.sql.error.messageFormat`  

`spark.sql.files.ignoreCorruptFiles`  
`spark.sql.files.ignoreMissingFiles`  

`spark.sql.parquet.writeLegacyFormat`  

`spark.dynamicAllocation.enabled`  
`spark.dynamicAllocation.initialExecutors`  
`spark.dynamicAllocation.minExecutors`  
`spark.dynamicAllocation.maxExecutors`  
``
``  

#### Spark workload optimization
[Optimize spark data workloads](https://www.databricks.com/discover/pages/optimize-data-workloads-guide)

`predicate pushdown`  
`set spark.sql.autoBroadcastJoinThreshold = <size in bytes>`  
`set spark.databricks.adaptive.autoBroadcastJoinThreshold = <size in bytes>`  
`set spark.sql.join.preferSortMergeJoin = true`  
`set spark.sql.cbo.enabled = true`  
`set spark.sql.shuffle.partitions=auto` : data spill and suffle partitions

```text
-- in SQL
set spark.sql.shuffle.partitions = 2*<number of total worker cores in cluster>
-- in PySpark
spark.conf.set(“spark.sql.shuffle.partitions”, 2*<number of total worker cores in cluster>)
-- or
spark.conf.set(“spark.sql.shuffle.partitions”, 2*sc.defaultParallelism)
```
`set spark.sql.adaptive.skewJoin.enabled = true` : data skew
```text
-- default is 5
set spark.sql.adaptive.skewJoin.skewedPartitionFactor = <value>
-- default is 256MB
set spark.sql.adaptive.skewJoin.skewedPartitionThresholdInBytes = <size in bytes>
```

`set spark.sql.files.maxPartitionBytes = <size in bytes>`