[Dbx CLI Tutorial](https://docs.databricks.com/aws/en/dev-tools/cli/)

#### Install CLI
```shell
winget search databricks
winget install Databricks.DatabricksCLI
```

#### Configure OAuth U2M token

```shell
databricks auth login --host <account-console-url> --account-id <account-id>
```

```shell
databricks auth login --host <workspace-url>
```
After authentication succeed, `.databrickscfg` file will be created in user home directory. This file contains all your profiles.

#### Show informations about profiles
List configured profiles
```shell
databricks auth profiles
```

```shell
databricks auth env --profile <configuration-profile-name>

# Or:
databricks auth env --host <account-console-url>

# Or:
databricks auth env --host <workspace-url>
```
View a profile’s current OAuth token value
```shell
databricks auth token -p <profile-name>
databricks auth token --host <workspace-url>
databricks auth token --host <workspace-url> -p <profile-name>
```
#### Commands group hellp
```shell
databricks -h
databricks <command-group> -h
databricks <command-group> <command-name> -h
databricks <command-group> <command-name> <subcommand-name> -h
```
Examples commands
```shell
databricks clusters list
databricks fs ls dbfs:/
```

#### Databricks bundle
Init a project
```shell
databricks bundle init
```
```shell
databricks bundle validate
```

```shell
databricks bundle sync --dry-run
```

```shell
databricks bundle sync
```

```shell
databricks bundle deploy -t dev
```

```shell
databricks bundle summary
```

```shell
databricks bundle run test_sql_sql_job
```

```shell
databricks bundle destroy
```

#### Databricks clusters group command
Show clusters command help
```shell
databricks clusters -h
```

List available clusters
```shell
databricks clusters list
```

Start clusters
```shell
databricks clusters start 0430-115215-tj6mdung
```

#### Databricks fs group command
Show fs command help
```shell
databricks fs -h
```

```shell
databricks fs ls dbfs:/
```