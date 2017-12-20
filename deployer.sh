# Get the repository URL
REPO_URL=$(git config --get remote.origin.url)

# Simple help command
help_command() {
  echo "Usage: deployer.sh <command> <commit_hash>"
  echo "Available commands: start, stop"
}

# This command starts the snapshot
start_command() {
  if [ -z "$2" ]; then
    echo "Commit hash of the snapshot must be provided!"
    return 1
  fi
  echo "Starting shapshot $2..."
  rm -rf /tmp/$2
  git clone $REPO_URL /tmp/$2
  cd /tmp/$2
  git checkout $2
  cp .env.example .env
  COMPOSE_PROJECT_NAME=$2 docker-compose up -d
  APP_CONTAINER="$2_todomvc-turbolinks_1"
  APP_PORT=$(docker inspect $APP_CONTAINER --format='{{(index (index .NetworkSettings.Ports "3000/tcp") 0).HostPort}}')
  echo "Application is running at http://0.0.0.0:$APP_PORT"
}

# This commands terminates the snapshot
stop_command() {
  if [ -z "$2" ]; then
    echo "Commit hash of the snapshot must be provided!"
    return 1
  fi
  echo "Terminating shapshot $2..."
  COMPOSE_PROJECT_NAME=$2 docker-compose down
  echo "Done!"
}

case $1 in
  help)
    help_command
    ;;
  start)
    start_command $1 $2
    ;;
  stop)
    stop_command $1 $2
    ;;
  *)
    echo "Incorrect usage \n"
    help_command
  esac
