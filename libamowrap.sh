# Means For Locating and Verifying Non-Builtins
function Validate {
    [ -d "$1" ] && Results="$1" && return 0
    ItsType=$(type -t $1 || return 1)
    [[ "${ItsType}" == +(file) ]] && Results=$( type -P $1 ) && return 0
    [[ "${ItsType}" == +(alias|keyword|function|builtin)  ]] && return 1
}

function Failed {
    MyNameIs=$(echo $MyNameIs | ${sed} -e 's/^[a-z]?/[A-Z]/g')
    ${Logger} -i -t $MyNameIs -- "Error - $@"
    echo "$@"
    exit 2
}
function List_Options {
    local AllOptions=$(grep ^[A-Z].*\=\".*\"[\ ]*$ ${AmoConf} || echo "NONE")

    echo -e "\nSystem Default Options\n----------------------\n$AllOptions"

    exit 0
}
