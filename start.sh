#! /bin/bash

echo "Checking enviroment variables..."

function checkEnv {
    [ -z "$2" ] && echo "Need to set $1" && exit 1;
}

function checkFile {
	[ ! -f $1 ] && echo "File $1 not found!" && exit 1;
}

checkEnv TTL_PATH $TTL_PATH
checkEnv ODBA_PATH $ODBA_PATH
checkEnv PROPERTIES_PATH $PROPERTIES_PATH

checkFile "./input/$TTL_PATH"
checkFile "./input/$ODBA_PATH"
checkFile "./input/$PROPERTIES_PATH"

./ontop endpoint --ontology="input/$TTL_PATH" --mapping="input/$ODBA_PATH" --properties="input/$PROPERTIES_PATH"