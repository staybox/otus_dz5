# OTUS ДЗ 5 Управление процессами (Centos 7)
-----------------------------------------------------------------------
### Домашнее задание

    Работаем с процессами
    Цель: В результате ДЗ вы разберетесь что находится в файловой системе /proc и закрепите навыки работы с bash. Зачастую, например в контейнерах, у вас нет кучу удобных утилит предоставляющих информацию о процессах, ip адресах, итд И есть только один инструмент bash и /proc
    Задания на выбор
    1) написать свою реализацию ps ax используя анализ /proc
    - Результат ДЗ - рабочий скрипт который можно запустить
    2) написать свою реализацию lsof
    - Результат ДЗ - рабочий скрипт который можно запустить
    3) дописать обработчики сигналов в прилагаемом скрипте, оттестировать, приложить сам скрипт, инструкции по использованию
    - Результат ДЗ - рабочий скрипт который можно запустить + инструкция по использованию и лог консоли
    4) реализовать 2 конкурирующих процесса по IO. пробовать запустить с разными ionice
    - Результат ДЗ - скрипт запускающий 2 процесса с разными ionice, замеряющий время выполнения и лог консоли
    5) реализовать 2 конкурирующих процесса по CPU. пробовать запустить с разными nice
    - Результат ДЗ - скрипт запускающий 2 процесса с разными nice и замеряющий время выполнения и лог консоли
    Критерии оценки: 5 баллов - принято - любой скрипт
    +1 балл - больше одного скрипта
    +2 балла все скрипты

### Скрипты

1. [ionice.sh] - Скрипт состоит из двух частей. 
А) Запускает параллельно два работающих процесса с флагом для включения режима прямой записи на диск.
Б) Запускает параллельно два работающих процесса без флага прямой записи на диск.
Рекомендуется перед запуском закоментировать одну из частей. 
С помощью команды time происходит подсчет времени.
2. [lsof.sh] - Простой аналог команды lsof. Программа показывает PID, USER, открытые файлы, и каким процессом они открыты. Данные извлекаются из псевдофайловой системы proc.
Формат вывода:
PID        USER                 NAME                                      COMM
1          root                 /usr/lib/systemd/systemd               systemd
1          root                 /usr/lib/systemd/systemd               systemd
1          root                 /usr/lib/systemd/systemd               systemd
1          root                 /usr/lib64/libuuid.so.1.3.0            systemd
1          root                 /usr/lib64/libuuid.so.1.3.0            systemd
1          root                 /usr/lib64/libuuid.so.1.3.0            systemd
1          root                 /usr/lib64/libuuid.so.1.3.0            systemd
1          root                 /usr/lib64/libblkid.so.1.1.0           systemd
1          root                 /usr/lib64/libblkid.so.1.1.0           systemd
1          root                 /usr/lib64/libblkid.so.1.1.0           systemd
1          root                 /usr/lib64/libblkid.so.1.1.0           systemd
1          root                 /usr/lib64/libz.so.1.2.7               systemd
1          root                 /usr/lib64/libz.so.1.2.7               systemd
1          root                 /usr/lib64/libz.so.1.2.7               systemd
1          root                 /usr/lib64/libz.so.1.2.7               systemd
1          root                 /usr/lib64/liblzma.so.5.2.2            systemd
1          root                 /usr/lib64/liblzma.so.5.2.2            systemd
1          root                 /usr/lib64/liblzma.so.5.2.2            systemd
1          root                 /usr/lib64/liblzma.so.5.2.2            systemd

3. [myfork.py] - В этом скрипте добалены обработчики некоторых сигналов. SIGHUP, SIGINT, SIGTERM. Например чтобы прервать работу скрипта можно нажать Ctrl+C и скрипту будет отправлен сигнал SIGINT (номер 2). Обработчики сигналов позволяют прервать работу скрипта после отправки им определенных сигналов и вывести пользователю какую либо информацию. Конечно без этих обработчиков также можно будет выйти из скрипта, однако будет выведена ошибка, а с обработчиками ошибки не будет. В скрипте в комментариях указаны какие команды были добавлены и что они делают.
4. [nice.sh] - Скрипт, который запускает параллельно два процесса с разными приоритетами. Приоритет выставляется на процессорное время. В скрипте мы можем увидеть разницу.
5. [ps.sh] - Скрипт, простой аналог ps au. Данные извлекаются из псевдофайловой системы proc.
    Формат вывода:
    PID                           USER                          COMM                                                                                 STAT      RSS
    1                             root                          /usr/lib/systemd/systemd--switched-root--system--deserialize22                       S         3256
    2                             root                          [kthreadd]                                                                           S
    3                             root                          [ksoftirqd/0]                                                                        S
    5                             root                          [kworker/0:0H]                                                                       S
    7                             root                          [migration/0]                                                                        S
    8                             root                          [rcu_bh]                                                                             S
    9                             root                          [rcu_sched]                                                                          S
    10                            root                          [lru-add-drain]                                                                      S
    11                            root                          [watchdog/0]                                                                         S
    13                            root                          [kdevtmpfs]                                                                          S
    14                            root                          [netns]                                                                              S
    15                            root                          [khungtaskd]                                                                         S
    16                            root                          [writeback]                                                                          S
    17                            root                          [kintegrityd]                                                                        S


[ionice.sh]:https://github.com/staybox/otus_dz5/blob/master/ionice.sh
[lsof.sh]:https://github.com/staybox/otus_dz5/blob/master/lsof.sh
[myfork.py]:https://github.com/staybox/otus_dz5/blob/master/myfork.py
[nice.sh]:https://github.com/staybox/otus_dz5/blob/master/nice.sh
[ps.sh]:https://github.com/staybox/otus_dz5/blob/master/ps.sh