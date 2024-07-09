# Đường dẫn đến thư mục chứa tệp sao lưu
BACKUP_DIR="/tmp/docker_all_containers"

for file in $BACKUP_DIR/*.tar; do
  docker import $file $(basename $file .tar)
  echo "Container $file đã được khôi phục."
done
