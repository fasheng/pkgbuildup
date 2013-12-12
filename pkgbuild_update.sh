#!/usr/bin/bash
#
#   Author: Xu FaSheng <fasheng.xu@gmail.com>
#   
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 3, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.


### Functions

msg() {
    printf "==> $*\n"
}

warning() {
    printf "==> WARNING: $*\n"
}

error() {
    printf "==> ERROR: $*\n" >&2
    exit 1
}



# Get latest file in source site.
# arguments:
#   $1, the parent path of url
#   $2, desired file name
#   $3, regexp of file name, used to get the last file name
get_latest_file() {
    # get arguments
    local parent_url=$1
    local file=$2
    local file_reg=$3
    
    # check if w3m installed
    command -v w3m >/dev/null 2>&1 || {
        echo ${file}
        return
    }
    
    # get the latest file, and for some source site, need convert character "%2b" to "+"
    matched_files=`w3m -dump_source ${parent_url} | sed "s/%2b/+/" | grep -o -P ${file_reg}`
    latest_file=`echo "${matched_files}" | sort -n | tail -1`
    if [[ -z ${latest_file} ]]; then
        # get latest file failed
        echo ${file}
        return
    fi
    
    if [[ ${latest} = ${file} ]]; then
        # found it, the original file url is still alive
        echo ${file}
        return
    fi
    
    # package url is out of date, return the latest one
    echo ${latest_file}
}


### Main
# config bash
shopt -s extglob

# Options

# The download utilities that should use to acquire sources
#  Format: 'protocol::agent'
if [[ -z "${DLAGENTS}" ]]; then
    DLAGENTS=('ftp::/usr/bin/curl -fC - --ftp-pasv --retry 3 --retry-delay 3 -o %o %u'
              'http::/usr/bin/curl -fLC - --retry 3 --retry-delay 3 -o %o %u'
              'https::/usr/bin/curl -fLC - --retry 3 --retry-delay 3 -o %o %u'
              'rsync::/usr/bin/rsync --no-motd -z %u %o'
              'scp::/usr/bin/scp -C %u %o')
fi

if [[ -z "${UPDATE_SCRIPT}" ]]; then
    UPDATE_SCRIPT='${PWD}/PKGBUILD_UPDATE'
fi

if [[ -z "${TEMPLATE_FILE}" ]]; then
    error "need option $TEMPLATE_FILE"
fi

if [[ -z "${TEMPLATE_VALUES}" ]]; then
    warning "$TEMPLATE_VALUES is empty"
    TEMPLATE_VALUES=""
fi



