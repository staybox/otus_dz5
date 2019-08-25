#!/bin/bash

# Запускаем замер по времени на команду ionice с флагом direct, т.е. прямая запись на диск (запускается 2 команды одновременно)
time ionice -c1 -n0 su -c "dd if=/dev/zero of=/tmp/test.img bs=512 count=1M oflag=direct" & time ionice -c2 -n7 su -c "dd if=/dev/zero of=/tmp/test2.img bs=512 count=1M oflag=direct" &

# Результат
# 1048576+0 records in
# 1048576+0 records out
# 536870912 bytes (537 MB) copied, 224.279 s, 2.4 MB/s

# real    3m44.298s
# user    0m1.875s
# sys     1m48.269s
# 1048576+0 records in
# 1048576+0 records out
# 536870912 bytes (537 MB) copied, 224.294 s, 2.4 MB/s

# real    3m44.308s
# user    0m1.983s
# sys     1m48.542s


# Запускаем замер по времени на команду ionice без флага direct (запускается 2 команды одновременно)
time ionice -c1 -n0 su -c "dd if=/dev/zero of=/tmp/test.img bs=512 count=1M" & time ionice -c2 -n7 su -c "dd if=/dev/zero of=/tmp/test2.img bs=512 count=1M" &

# Результат
# 1048576+0 records in
# 1048576+0 records out
# 536870912 bytes (537 MB) copied, 4.37828 s, 123 MB/s
# 1048576+0 records in
# 1048576+0 records out
# 536870912 bytes (537 MB) copied, 4.36668 s, 123 MB/s

# real    0m4.424s
# user    0m0.287s
# sys     0m1.689s

# real    0m4.424s
# user    0m0.265s
# sys     0m1.727s

#Также чтобы выключить I/O caching на уровне ОС, необходимо изменить значение vm.drop_caches = 0 (sysctl -a | grep vm.drop) с 0 на 3. Тогда не обязательно включать опцию прямой записи на диск.