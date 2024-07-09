
# chmod +x down_container.sh

BACKUP_DIR="/tmp/backup_containers"

for container in $(docker ps -q); do
  docker export -o $BACKUP_DIR/$container.tar $container
  echo "Container $container đã được backup."
done
