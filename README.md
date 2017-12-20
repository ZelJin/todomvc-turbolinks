## TodoMVC with Turbolinks 3

An implementation of TodoMVC using Rails 5 and Turbolinks 3

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

#### Deployment with Docker

```
cp .env.example .env
docker-compose up -d
```

#### Deployment with `deployer` script

This application comes with the `deployer` script, that can automatically
provision and run multiple versions of TodoMVC.

##### Prerequisites
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/overview/)

You can start the application with the following command:

`./deployer start <commit_hash>`

The application can be terminated with the following command:

`./deployer stop <commit_hash>`

Please note that the earliest possible commit hash that is compatible with
this tool is `44d91fd`. Before this commit there was a race condition related to the starting order of the containers. You can check [this link](https://docs.docker.com/compose/startup-order/) on container startup order in Docker Compose for more details. 

If the script is not working, please use `chmod` to make the script executable:

`chmod u+x deployer`
