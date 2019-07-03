
#!/bin/bash
# ------------------------------------------------------------------
# [Author] Title
#          Description
# ------------------------------------------------------------------

set -e
set -x

echo "I'm running as user $USER"


function enable_bashrcd() {
	local BASH_PROFILE_FILE=${1}
	cat <<\EOF >> "${BASH_PROFILE_FILE}"
###begin enabling bashrc.d###
# This churns through files in $HOME/.bashrc.d if they are executable.
if [ -d $HOME/.bashrc.d ]; then
	for x in $HOME/.bashrc.d/* ; do
		if [[ "${x}" != "bashrc.init" ]]; then
			source "${x}"
		fi
	done
fi
###end enabling bashrc.d###
EOF
## WARNING: remember to update the function check_if_enabled_bashrc
}


function check_if_enabled_bashrcd() {
	local  BASH_PROFILE_FILE=${1}

	local  TEXT_TO_CHECK=$(cat <<\END
###begin enabling bashrc.d###
# This churns through files in $HOME/.bashrc.d if they are executable.
if [ -d $HOME/.bashrc.d ]; then
	for x in $HOME/.bashrc.d/* ; do
		if [[ "${x}" != "bashrc.init" ]]; then
			source "${x}"
		fi
	done
fi
###end enabling bashrc.d###
END
)
    echo "printo text to check"
	printf "$TEXT_TO_CHECK"
	echo '**********'
	TEXT_FOUND=$(cat "${BASH_PROFILE_FILE}" | sed -n '/^###begin enabling bashrc.d###$/,/^###end enabling bashrc.d###$/p')
	echo --------------
    printf $TEXT_FOUND
	set -x
    if [ "${TEXT_TO_CHECK}" == "${TEXT_FOUND}" ]; then
		return 0
	else
		return 1
	fi


}

cleanup_artefact() {
   echo '**************************************************'
   echo "to implemt"
   echo '**************************************************'
   exit 1
}


function main() {

	local BASH_PROFILE_FILE="${1}"
	if  check_if_enabled_bashrcd ${BASH_PROFILE_FILE};  then
		echo "the bashrc.d is already enabled"
	else
	    echo "enabling bashrcd"
	 	enable_bashrcd "${BASH_PROFILE_FILE}"
    fi

}

BASH_PROFILE_FILE=${1}
main "${BASH_PROFILE_FILE}"

