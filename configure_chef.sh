#!/bin/bash
# ------------------------------------------------------------------
# [Author] Title
#          Description
# ------------------------------------------------------------------

set e
set -x

echo "$USER"


begin_string="###begin enabling bashrc.d###"
end_string="###end enabling bashrc.d###"



function enable_bashrcd() {
    BASH_PROFILE_FILE=${1}
	cat <<-\EOF >> "${BASH_PROFILE_FILE}"

	# This churns through files in $HOME/.bashrc.d if they are executable.
	if [ -d $HOME/.bashrc.d ]; then
    		for x in $HOME/.bashrc.d/* ; do
        		if [[ "${x##*/}" != "bashrc.init" ]]; then
            			test -f "${x}" || continue
            			test -x "${x}" || continue
            			. "${x}"
        		fi
    		done
	fi
	EOF
}




main() {

enable_bashrcd mio

}

main
#echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
#echo 'export PATH="/opt/chefdk/embedded/bin:$PATH"' >> ~/.bash_profile
