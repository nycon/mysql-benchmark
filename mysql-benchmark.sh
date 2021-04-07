#!/bin/bash
#============================================================================
#title          :mysql-benchmark.sh
#description    :mysql Benchmark Script.
#author         :Marco Stoeckle xelon AG
#date           :2021-07-04
#version        :0.1
#usage          :./mysql-benchmark.sh
#notes          :
#bash_version   :
#============================================================================
#============================================================================
### Revision History:
##
##	Date	      Version			Personnel			Notes
##	----	      -------			----------------	-----
##	202-07-04	  0.1			    Marco Stoeckle   	Script created
##  
##	
#============================================================================
#
GREEN='\033[0;32m'
NC='\033[0m'

function test1 {
	echo -e "${GREEN}#-----------------------------------#${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}Install sysbench${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}#-----------------------------------#${NC}"

    echo -e "${GREEN}Make Update${NC}"
    apt update
    echo -e "${GREEN}Install sysbench${NC}"
    apt install sysbench

	exit 0
    }

function test2 {
	echo -e "${GREEN}#-----------------------------------#${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}Load Test${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}#-----------------------------------#${NC}"

	read -p 'mysql Host IP: ' ip
    read -p 'mysql Host Port: ' port
    echo -e "${GREEN}Make Test${NC}"
    sysbench \
    --db-driver=mysql \
    --mysql-user=sbtest_user \
    --mysql_password=password \
    --mysql-db=sbtest \
    --mysql-host=${ip} \
    --mysql-port=${port} \
    --tables=16 \
    --table-size=10000 \
    /usr/share/sysbench/oltp_read_write.lua prepare
	exit 0
    }

function test3 {
	echo -e "${GREEN}#-----------------------------------#${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}Write-heavy traffic with end Report${NC}"
	echo -e ""
	echo -e ""
	echo -e "${GREEN}#-----------------------------------#${NC}"

	read -p 'mysql Host IP: ' ip
    read -p 'mysql Host Port: ' port
    echo -e "${GREEN}Make Test${NC}"
    sysbench \
    --db-driver=mysql \
    --mysql-user=sbtest_user \
    --mysql_password=password \
    --mysql-db=sbtest \
    --mysql-host=${ip} \
    --mysql-port=${port} \
    --tables=16 \
    --table-size=10000 \
    --threads=8 \
    --time=300 \
    --events=0 \
    --report-interval=1 \
    --rate=40 \
    /usr/share/sysbench/oltp_read_write.lua run
	exit 0
    }
clear

# Selection menu
selection=
until [ "$selection" = "0" ]; do
	 echo -e -e "${GREEN}*-----------------------------------*${NC}"
	 echo -e "${GREEN}Mysql Benchmark Test ${NC}" 
     echo -e ""
     echo -e ""
     echo -e "${GREEN}Read the README first befor you start! ${NC}"
	 echo -e ""
     echo -e ""
     echo -e "${GREEN}*-----------------------------------*${NC}"
	 echo -e "${GREEN}1 - install sysbench ${NC}"
	 echo -e "${GREEN}2 - Load Test${NC}"
     echo -e "${GREEN}3 - Write-heavy traffic with end Report${NC}"
	 echo -e "${GREEN}0 - exit program${NC}"
	 echo -e "${GREEN}Enter selection:${NC} "
	read selection
	echo -e ""
	case $selection in
		1 )  test1 ;;
		2 )  test2 ;;
        3 )  test3 ;;
		0 ) exit & echo -e "${GREEN}the computer says no :-)${NC}";;
		* ) echo -e "${GREEN}Please enter 1, 2, 3 or 0${NC}"
	esac
done