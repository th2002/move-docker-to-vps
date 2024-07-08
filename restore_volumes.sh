#!/bin/bash

# Giải nén file tar gốc chưa volume list
# tar xzf docker-volumes-backup.tar.gz -C /tmp

# Đường dẫn đến thư mục chứa volume list vừa giải nén
BACKUP_DIR="/tmp/docker_volumes_backup"

# Lấy danh sách tất cả các tệp trong tệp sao lưu và giải nén vào các volumes tương ứng
for backup_file in "$BACKUP_DIR"/*.tar.gz; do
  # Lấy tên volume từ tên tệp sao lưu
  volume_name=$(basename "$backup_file" .tar.gz)
  
  # Tạo volume trong Docker nếu chưa tồn tại
  docker volume create "$volume_name" > /dev/null 2>&1
  
  # Giải nén tệp tar.gz vào volume
  docker run --rm -v "$volume_name":/volume -v "$BACKUP_DIR":/backup busybox sh -c "cd /volume && tar xzf /backup/$(basename "$backup_file") --strip 1"
  
  echo "Volume $volume_name đã được khôi phục."
done
