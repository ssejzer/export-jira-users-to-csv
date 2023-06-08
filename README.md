# export-jira-users-to-csv
Bash script to export users and group members in CSV format

# Usage


## create a .env file with your instance details and credentials

```ini
# Your Personal Access Token
# https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html
TOKEN=hip-hip-env-files
# Your instance URL
URL='https://jira.mycompany.com:8400'
```

## Run it!

### To get all the users
```bash
jirausers2csv.sh
```

### To get a group members
```bash
jirausers2csv.sh "group name"
```


