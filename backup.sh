#!/bin/bash

# Colourise the output
RED='\033[0;31m'        # Red
GRE='\033[0;32m'        # Green
YEL='\033[1;33m'        # Yellow
NCL='\033[0m'           # No Color

file_specification() {

    FILE_NAME="$(basename "${entry}")"
    DIR="$(dirname "${entry}")"
    SIZE="$(du -sh "${entry}" | cut -f1)"
        printf "%*s${GRE}%s${NCL}\n"                    $((indent+4)) '' "${entry}"
        printf "%*s\tFile name:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$FILE_NAME"
        printf "%*s\tDirectory:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$DIR"
        printf "%*s\tFile size:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$SIZE"
        printf "%*s\tCopying File To:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$DIR_sc"
}

scan() {
    # local indent="${2:-0}"
    # printf "\n%*s${RED}%s${NCL}\n\n" "$indent" '' "$1"
    # If the entry is a file do some operations
    counter=1
    FILE_NAME="$(basename "${entry}")"
    DIR="$(dirname "${entry}")"
    SIZE="$(du -sh "${entry}" | cut -f1)"
    for entry_sc in "$1"/* 
    do 
    if [ -f "$entry_sc" ] 
    then
    FILE_NAME_sc="$(basename "${entry_sc}")"
    DIR_sc="$(dirname "${entry_sc}")"
    SIZE_sc="$(du -sh "${entry_sc}" | cut -f1)"
    if [ $FILE_NAME = $FILE_NAME_sc -a $SIZE = $SIZE_sc ] 
    then
    counter=0
    fi
    fi
    done
    if [ $counter == 1 ]
    then
    file_specification
    cp ${entry} ${DIR_sc} 
    fi
}

file_specificationv2() {
        FILE_NAME="$(basename "${entry}")"
        DIR="$(dirname "${entry}")"
        SIZE="$(du -sh "${entry}" | cut -f1)"

        printf "%*s${GRE}%s${NCL}\n"                    $((indent+4)) '' "${entry}"
        printf "%*s\tFile name:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$FILE_NAME"
        printf "%*s\tDirectory:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$DIR"
        printf "%*s\tFile size:\t${YEL}%s${NCL}\n"      $((indent+4)) '' "$SIZE"
}

walkv2() {
    for entry in "$1"/*; do [[ -f "$entry" ]] && file_specificationv2; done
        # If the entry is a directory call walk() == create recursion
        for entry in "$1"/*; do [[ -d "$entry" ]] && walkv2 "$entry" $((indent+4)); done
}

walk() {
        # local indent="${2:-0}"
        # printf "\n%*s${RED}%s${NCL}\n\n" "$indent" '' "$1"
        # If the entry is a file do some operations
        for entry in "$1"/*; do [[ -f "$entry" ]] && scan "${fin_dir}"; done
        # If the entry is a directory call walk() == create recursion
        for entry in "$1"/* 
        do 
        if [ -d "$entry" ] 
        then
        sub_dir="${entry:$3}"
        fin_dir="${2}${sub_dir}"
        strlen_fin=`echo -n "${fin_dir}" | wc -m`
        strlen_ent=`echo -n "${entry}" | wc -m`
        if [ ! -d "$fin_dir" ]
        then
        FOLDER_NAME="$(basename "${entry}")"
        strlen=`echo -n "${FOLDER_NAME}" | wc -m`
        sre=`expr $strlen_fin - $strlen`
        cp_str=${fin_dir:0:$sre}
        cp -r $entry $cp_str 
        printf "\n%*s${RED}%s${NCL}\n\n" "$indent" '' "$cp_str"
        walkv2 "$entry"
        continue
        fi
        walk "$entry" "$fin_dir" $strlen_ent
        fi
        done
}

# If the path is empty use the current, otherwise convert relative to absolute; Exec walk()
[[ -z "${1}" ]] && exit -1 || cd "${1}" && ABS_PATH="${PWD}" 
cd ..
[[ -z "${2}" ]] && ABS_PATH_2="${PWD}" || cd "${2}" && ABS_PATH_2="${PWD}"
strlen_1=`echo -n "${ABS_PATH}" | wc -m`
strlen_2=`echo -n "${ABS_PATH_2}" | wc -m`
fin_dir="${ABS_PATH_2}"
echo "files copied from ${ABS_PATH} to ${ABS_PATH_2} are"
walk ${ABS_PATH} ${ABS_PATH_2} $strlen_1
fin_dir="${ABS_PATH}"
echo "files copied from ${ABS_PATH_2} to ${ABS_PATH} are"
walk ${ABS_PATH_2} ${ABS_PATH} $strlen_2

