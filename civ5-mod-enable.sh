#!/bin/bash
#### SETUP ####################################################################
set -o errexit
set -o errtrace
set -o nounset

#### Variables
# paths and file names
steam_path="${HOME}/Library/Application Support/Steam"
data_path="${HOME}/Documents/Aspyr/Sid Meier's Civilization 5"
mods_path="${data_path}/MODS"
cache_path="${data_path}/cache"
db_mods_file='Civ5ModsDatabase.db'
db_mods_path="${cache_path}/${db_mods_file}"
# regex
s='[[:space:]]*'
re_mods_button="^${s}Controls\.ModsButton:SetHide(${s}true${s});"
# operational
prog="${0##*/}"
opt_purge=0
usage="\
Usage:  ${prog} [ -P ]
        ${prog} -h

Updates Mac Civ5 to enable mods and installs subscribed Steam mods.

Options:
    -h      show this help message and exit
    -P      Purge existing mods before extracting Steam mods
"


#### FUNCTIONS ################################################################


help_print() {
    # Print help/usage, then exit (incorrect usage should exit 2)
    local _es=${1:-0}
    echo "${usage}"
    exit ${_es}
}


help_request_check() {
    # Print Help/Usage if requested
    local _arg
    shopt -s nocasematch
    # only accept help "action" in 1st position
    [[ "${1:-}" == 'help' ]] && help_print
    # evaulate all positional parameters for help options
    for _arg in "${@}"
    do
        case "${_arg}" in
            -h | -help | --help ) help_print
        esac
    done
    shopt -u nocasematch
    return 0
}


enable_mod_button() {
    local _file
    IFS=$'\n'
    for _file in $(find "${steam_path}" -type f -iname 'MainMenu.lua' -print)
    do
        unset IFS
        if grep -Iiq "${re_mods_button}" "${_file}"
        then
            echo "Updating [STEAM]...${_file##*.app}"
            sed -e "s/${re_mods_button}/-- &/" -i.bak "${_file}"
        else
            echo "Already updated: [STEAM]...${_file##*.app}"
        fi
    done
    echo
}

purge_mods() {
    local _cur_dir
    cd "${mods_path}"
    _cur_dir="$(pwd)"
    if [[ "${_cur_dir##*/}" != 'MODS' ]]
    then
        echo 'ERROR: wrong MOD directory.'
        exit 1
    fi
    echo 'Purging existing MODS'
    rm -rf *
    if [[ -f "${db_mods_path}" ]]
    then
        echo "Purging ${db_mods_file}"
        rm "${db_mods_path}"
    fi
    echo
}

extract_steam_mods() {
    local _mod_file _mod_name _mod_path
    cd "${mods_path}"
    IFS=$'\n'
    for _mod_path in $(find "${steam_path}" -type f -name '*.civ5mod' -print)
    do
        unset IFS
        _mod_file=${_mod_path##*/}
        _mod_name=${_mod_file%.civ5mod}
        if [[ ! -d "${_mod_name}" ]]
        then
            echo "Processing MOD: ${_mod_name}"
            mkdir -p "${_mod_name}"
            cd "${_mod_name}"
            7zr x -o. -y "${_mod_path}" >/dev/null
            cd ..
        fi
    done
}

vacuum_dbs() {
    # SQLite Database Maintenance
    # http://www.sqlite.org/lang_vacuum.html
    local _db _presize _postsize
    echo 'SQLite Database Maintenance--Vacuuming:'
    IFS=$'\n'
    for _db in $(find "${data_path}" -type f -name '*.db' -print)
    do
        unset IFS
        _db_name="[DATA]...${_db##${data_path}}"
        _presize=$(du -h "${_db}" | awk '{print $1}')
        printf '% -64s' "${_db_name}"
        sqlite3 "${_db}" 'VACUUM;'
        _postsize=$(du -h "${_db}" | awk '{print $1}')
        printf ' % 5s => % 5s\n' ${_presize} ${_postsize}
    done
    echo
}

#### MAIN #####################################################################


#### Parse options
help_request_check "${@:-}"
while getopts ':P' Option
do
    case ${Option} in
        P ) opt_purge=1 ;;
        * )
            echo "Invalid option: -${OPTARG}"
            exit 2
            ;;
    esac
done
shift $((${OPTIND} - 1))


enable_mod_button
if (( opt_purge == 1 ))
then
    purge_mods
fi
vacuum_dbs
extract_steam_mods
