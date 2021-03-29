#!/bin/bash
#!/bin/bash -x

# OpenSCAD.sh - Utility script to Launch OpenSCAD
#
# Tested on macOS mostly
#
# USAGE
#
# With no arguments, launches app.
#
#   ./scripts/OpenSCAD.sh
#
# Passes arguments to app, pruning any .scad or .stl to a single one
#
#   ./scripts/OpenSCAD.sh webcam_small_mount/webcam_base_bracket.scad
#


# from top-level of psychic-winner directory:
#   open --new -a /Applications/OpenSCAD.app --env OPENSCADPATH=`pwd`/libraries

#CURRENT_DIR="${PWD}"
LOCAL_TOP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && cd ../ && pwd )"
LOCAL_LIBRARIES_DIR=$( cd "${LOCAL_TOP_DIR}"/libraries/ && pwd )
# echo "$CURRENT_DIR"
# echo "$LOCAL_TOP_DIR"
# echo "$LOCAL_LIBRARIES_DIR"

# Darwin / Linux
os_name="$(uname -s)"

DEFAULT_LIBRARIES_DIR_macos="$HOME/Documents/OpenSCAD/libraries"
DEFAULT_LIBRARIES_DIR_linux="$HOME/.local/share/OpenSCAD/libraries"

app_linux="openscad"
app_path_linux="$(which $app_linux)"

app_macos="OpenSCAD.app"
app_path_macos="/Applications/${app_macos}"

case $os_name in
    Darwin*)
        DEFAULT_LIBRARIES_DIR="${DEFAULT_LIBRARIES_DIR_macos}"
        app_path="${app_path_macos}"
        app_bin="${app_path}"/Contents/MacOS/OpenSCAD
        ;;
    *)
        DEFAULT_LIBRARIES_DIR="${DEFAULT_LIBRARIES_DIR_linux}"
        app_path="${app_path_linux}"
        app_bin="${app_path}"
        ;;
esac

# exports (also be explicit below)
export OPENSCADPATH="$LOCAL_LIBRARIES_DIR:$DEFAULT_LIBRARIES_DIR"

echo OPENSCADPATH="$OPENSCADPATH"
# echo app_path=$app_path
# echo app_bin=$app_bin

# determine if there are any arguments on command line
if [ -z "${1}" ]
then
    # There are no arguments, so
    case $os_name in
        Darwin*)
            echo Starting "$app_path"...
            open -a "${app_path}" --env OPENSCADPATH="$OPENSCADPATH"
            ;;
        *)
            OPENSCADPATH=$OPENSCADPATH "${app_bin}"
            ;;
    esac

else
    # There are arguments, so tell openscad about them
    myArgs=( )
    scad_file=""

    for arg in "${@}" ; do
        case "$arg" in
            *.scad)
                bn=$(basename "$arg")
                dir="$( cd "$( dirname "$arg" )" && pwd )"
                #echo "$dir/$bn"
                # only keep last .scad argument if there's more than one
                scad_file="$dir/$bn"
            ;;
            *.stl)  # will open by creating Untitled.scad with an import
                bn=$(basename "$arg")
                dir="$( cd "$( dirname "$arg" )" && pwd )"
                #echo "$dir/$bn"
                # only keep last .scad/.stl argument if there's more than one
                scad_file="$dir/$bn"
            ;;
            *)
                #echo "$arg"
                myArgs+=("$arg")
            ;;
        esac
    done

    if [[ -n $scad_file ]] ; then
        #echo $scad_file
        myArgs=("${myArgs[@]}" "$scad_file")
    fi

    echo Using args: "${myArgs[@]}"

    case $os_name in
        Darwin*)
            # opens new app (if already running) and waits for app to exit
            open -n -W -a "${app_path}" --env OPENSCADPATH="$OPENSCADPATH" --args "${myArgs[@]}" &
            # can view stdout/stderr running binary directly like this:
            # "${app_bin}" "${myArgs[@]}"
            ;;
        *)
            OPENSCADPATH=$OPENSCADPATH "${app_bin}" "${myArgs[@]}"
            ;;
    esac
fi
