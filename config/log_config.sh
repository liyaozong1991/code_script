#!/bin/bash

function log {
        local msg
        local logtype
        logtype=$1
        msg=$2
        lineno=$3
        datetime=`date +%F %H:%M:%S`
        logformat="[${logtype}]\t${datetime}\tLINENO:${lineno}\t${msg}"
        {   
        case $logtype in  
                DEBUG)
                        [[ $loglevel -le 0 ]] && echo -e "${logformat}" ;;
                INFO)
                        [[ $loglevel -le 1 ]] && echo -e "${logformat}" ;;
                WARNING)
                        [[ $loglevel -le 2 ]] && echo -e "${logformat}" ;;
                ERROR)
                        [[ $loglevel -le 3 ]] && echo -e "${logformat}" ;;
        esac
        } | tee -a $logfile
}

debug () {
        message=$1
        lineno=`caller 0 | awk '{print$1}'`
        log DEBUG "${message}" ${lineno}
}
info() {
        message=$1
        lineno=`caller 0 | awk '{print$1}'`
        log INFO "${message}" ${lineno}
}
warn() {
        message=$1
        lineno=`caller 0 | awk '{print$1}'`
        log WARNING "${message}" ${lineno}
}
error() {
        message=$1
        lineno=`caller 0 | awk '{print$1}'`
        log ERROR "${message}" ${lineno}
}
