#!/usr/bin/env bash

# echo "Let's start a project"

DESTINATION=$1
TEMPLATE=$2

if [ -z $DESTINATION ]; then
  echo "What is the name of the new project?"
  exit 1
fi

# You need to specify the template.
if [ -z $TEMPLATE ]; then
  echo "You must specify the template."
  exit 1
fi

# echo "  based on $TEMPLATE"

# Where are the templates stored?
# TODO: Make this configurable by reading from .rc.
TEMPLATE_DIR=~/.start-project/templates/
mkdir -p $TEMPLATE_DIR

# Can we find this template?
TEMPLATE_PATH=$TEMPLATE_DIR$TEMPLATE
if [ -d $TEMPLATE_PATH ]; then

  # TODO: Separate destination path and basename.
  if [ -z $DESTINATION ]; then
    echo "What is the name of the new project?"
    exit 1

  else
    # echo "  called $DESTINATION."

    if [ -d $DESTINATION ]; then
      echo "$DESTINATION already exists."
      exit 1
    else

      git clone $TEMPLATE_PATH $DESTINATION &>/dev/null
      CLONE_RESULT=$?
      if [ $CLONE_RESULT -ne 0 ]; then
        echo "The template could not be cloned."
        exit 1

      else

        cd $DESTINATION
        # Replace the placeholders with the project name.
        # TODO: Note dependency on Ag.
        ag PROJECT_NAME -l | xargs sed -e "s/PROJECT_NAME/$DESTINATION/g" -i ''

        # Remove Git evidence.
        rm -rf .git

        # echo "👍 Party on."
      fi
    fi
  fi

else
  echo "$TEMPLATE_PATH does not exist."
  exit 1
fi
