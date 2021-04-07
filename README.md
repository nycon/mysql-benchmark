##Sysbench Installation

First, we need to install the sysbench, I am installing sysbench on another server so that we can test the actual impact of load on our MySQL server.

install sysbench over the Script

```
git clone https://github.com/nycon/mysql-test.git
cd mysql-benchmark
./mysql-benchmark.sh
```
```
*-----------------------------------*
Mysql Benchmark Test 


Read the README first befor you start! 


*-----------------------------------*
1 - install sysbench 
2 - Load Test
3 - Write-heavy traffic with end Report
0 - exit program
Enter selection: 
```


##Ready Environment for SysBench:

For this test, I am creating the sbtest database and user sbtest_user and will grant all PRIVILEGES to sbtest_user on sbtest database.

using root;
```

mysql> create database sbtest
mysql> create user sbtest_user identified by 'password';
mysql> grant all on sbtest.* to `sbtest_user`@`%`;
mysql> show grants for sbtest_user;
+---------------------------------------------------------+
| Grants for sbtest_user@%                                |
+---------------------------------------------------------+
| GRANT USAGE ON *.* TO `sbtest_user`@`%`                 |
| GRANT ALL PRIVILEGES ON `sbtest`.* TO `sbtest_user`@`%` |
+---------------------------------------------------------+
```

