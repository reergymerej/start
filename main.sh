#!/usr/bin/env bash
set -xe

function check_dependencies {
  for x in git sed awk; do
    which ${x} 1>&2 >/dev/null
	if [[ $? -ne 0 ]]; then
	  printf "dependency check failed! ${x} not found in PATH\n"
	  exit 2
	fi
  done
  return 0
}
# this implements future options "post-clone"
function post_setup {
  local config_source=~/.start-project/config #  ${XDG_CONFIG_HOME}/start-project/config
  if [[ -f ${config_source} && -z $broken_enabled ]]; then
    #such a hack begin_ and end_ are a poor man's delimiter! ugh this isn't good, but should work for now
	# not working as well as I hoped, I am keeping this here to share the idea
    local commands=$(awk '/begin_post_setup_steps/{ getline cmd; if (cmd ~ /end_post_setup_steps/){ exit;}; print "\047"cmd"\047", cmd }' $config_source)
	echo $commands
	for cmd in ${commands}; do
	   echo ${cmd} |bash 
	done
  elif [[ -d ${XDG_CONFIG_HOME}/start-project/post-setup ]]; then
  # this is another way of accomplishing it, user's bring their own scripts
    for sh in ${XDG_CONFIG_HOME}/start-project/post-setup; do
	  bash ${XDG_CONFIG_HOME}/start-project/post-setup/$sh
	done
  fi 
}

check_dependencies
# echo "Let's start a project"


DESTINATION=$1
TEMPLATE=$2

if [ -z $DESTINATION ]; then
  echo "What is the name of the new project?"
  exit 1
fi

if [ $1 = "--version" ]; then
  echo "1.2.0"
  exit 0
fi


# echo "  based on $TEMPLATE"

# Where are the templates stored?
# TODO: Make this configurable by reading from .rc.
# above is kinda done: if template dir is already set use that, otherwise 
# use $HOME/.start-project/templates/ as the default
mkdir -p ${TEMPLATE_DIR:-$HOME/.start-project/templates/}

# You need to specify the template.
if [ -z $TEMPLATE ]; then
  echo "You must specify the template."

  # list available
  ls $TEMPLATE_DIR
  exit 1
fi

# Can we find this template?
TEMPLATE_PATH=$TEMPLATE_DIR$TEMPLATE
if [ -d $TEMPLATE_PATH ]; then
  # Separate destination path and basename (consider wrapping this in a function so that they aren't exported):
  dest_base=${DESTINATION%/.*}
  dest_dir=${DESTINATION#/.*}
  if [ -z $DESTINATION ]; then
    echo "What is the name of the new project?"
    exit 1

  else
    # echo "  called $DESTINATION."

    if [ -d $DESTINATION ]; then
      echo "$DESTINATION already exists."
      exit 1
    else

	  # Retain ref to template project so clones can pull in changes later. 
	  # Perhaps rsync? that would look at dates, but maybe store the map in the config file
      git clone $TEMPLATE_PATH $DESTINATION &>/dev/null 
      CLONE_RESULT=$?
      if [ $CLONE_RESULT -ne 0 ]; then
        echo "The template could not be cloned."
        exit 1

      else
	    # this tracks the ref of the template (as mentioned in future options)
        config_source=~/.start-project/config #  ${XDG_CONFIG_HOME}/start-project/config
	    if [[ $(grep -e ${DESTINATION} $config_source ) ]]; then
	      sed -ie "s%${DESTINATION}=%${DESTINATION}=$\(git --work-tree $DESTINATION rev-parse --short HEAD\)%" $config_source
	    else
	      echo "${DESTINATION}=$(git --work-tree $DESTINATION rev-parse --short HEAD)" >> $config_source
        fi
		# Do we need to cd? often this is where things could break, if a script
		# forgets to cd back, it also allows for a path to be specified
        cd $DESTINATION
		post_setup
        # Replace the placeholders with the project name.
        # TODO: Note dependency on Ag. could also do `eval ${search_cmd} | xargs....`
        ag PROJECT_NAME -l ${DESTINATION} | xargs -I{} -P 4 sed -ie "s/PROJECT_NAME/$DESTINATION/g" {}
		#just for fun, awk, related to future options ag alternatives (grep works too!)
        #awk -v dest=${DESTINATION} '/PROJECT_NAME/{gsub("PROJECT_NAME",dest,$0); print $0}' ${DESTINATION}/*
        # Remove Git evidence.
        rm -rf ${DESTINATION}/.git

        # echo "👍 Party on."
      fi
    fi
  fi

else
  echo "$TEMPLATE_PATH does not exist."
  exit 1
fi

