#!/bin/bash

function log {
        local msg
        local logtype
        logtype=$1
        msg=$2
        lineno=$3
        datetime=`date +'%F %H:%M:%S'`
        logformat="[${logtype}]\t${datetime}\tfuncname: ${FUNCNAME[@]}\t[line:${lineno}]\t${msg}"
        {   
        case $logtype in  
                debug)
                        [[ $loglevel -le 0 ]] && echo -e "\033[30m${logformat}\033[0m" ;;
                info)
                        [[ $loglevel -le 1 ]] && echo -e "\033[32m${logformat}\033[0m" ;;
                warn)
                        [[ $loglevel -le 2 ]] && echo -e "\033[33m${logformat}\033[0m" ;;
                error)
                        [[ $loglevel -le 3 ]] && echo -e "\033[31m${logformat}\033[0m" ;;
        esac
        } | tee -a $logfile
}

debug () {
        log debug "there are $# parameters:$@"
}
info() {
        message=$1
        lineno=`caller 0 | awk '{print$1}'`
        log info "${message}" ${lineno}
}
warn() {
        message=$1
        lineno=`caller 0 | awk '{print$1}'`
        log warn "${message}" ${lineno}
}
error() {
        message=$1
        lineno=`caller 0 | awk '{print$1}'`
        log error "${message}" ${lineno}
}
